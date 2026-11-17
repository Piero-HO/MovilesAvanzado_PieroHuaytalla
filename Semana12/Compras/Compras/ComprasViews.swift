import SwiftUI
import SwiftData

struct NuevaCompraView: View {
    let usuario: Usuario
    @Environment(\.modelContext) private var contexto
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]
    @Query(sort: \Producto.nombre) private var productos: [Producto]
    @State private var proveedor: Proveedor?
    @State private var producto: Producto?
    @State private var cantidad = 1
    @State private var costo = ""
    @State private var credito = false
    @State private var mensaje = ""
    var precio: Double { Double(costo.replacingOccurrences(of: ",", with: ".")) ?? 0 }
    var subtotal: Double { (Double(cantidad) * precio * 100).rounded() / 100 }
    var igv: Double { (subtotal * 18).rounded() / 100 }
    var total: Double { subtotal + igv }
    var body: some View {
        Form {
            Section("Compra") {
                Picker("Proveedor", selection: $proveedor) { Text("Seleccionar").tag(nil as Proveedor?); ForEach(proveedores) { Text($0.nombre).tag(Optional($0)) } }
                Picker("Producto", selection: $producto) { Text("Seleccionar").tag(nil as Producto?); ForEach(productos) { Text($0.nombre).tag(Optional($0)) } }
                Stepper("Cantidad: \(cantidad)", value: $cantidad, in: 1...100000)
                TextField("Costo unitario", text: $costo).keyboardType(.decimalPad)
                Toggle("Crédito a 30 días", isOn: $credito)
            }
            Section("Resumen") {
                LabeledContent("Subtotal", value: dinero(subtotal)); LabeledContent("IGV (18 %)", value: dinero(igv)); LabeledContent("Total", value: dinero(total))
                if total >= 5000 { Text("Esta compra requiere aprobación del supervisor.").foregroundStyle(.orange) }
            }
            Button(total >= 5000 ? "Enviar a aprobación" : "Registrar compra") { registrar() }
                .disabled(proveedor == nil || producto == nil || precio <= 0 || !precio.isFinite)
        }
        .navigationTitle("Nueva compra").toolbar { CuentaMenu() }
        .alert("Compra", isPresented: Binding(get: { !mensaje.isEmpty }, set: { if !$0 { mensaje = "" } })) { Button("Aceptar", role: .cancel) {} } message: { Text(mensaje) }
    }
    private func registrar() {
        guard let proveedor, let producto, precio > 0, precio.isFinite else { return }
        let compra = Compra(cantidad: cantidad, costoUnitario: precio, alCredito: credito, comprador: usuario, proveedor: proveedor, producto: producto)
        contexto.insert(compra)
        if compra.estado == "Aprobada" { compra.aplicarInventario() }
        do { try contexto.save(); mensaje = compra.estado == "Pendiente" ? "Compra enviada a aprobación." : "Compra registrada."; cantidad = 1; costo = "" }
        catch { contexto.rollback(); mensaje = "No se pudo registrar la compra." }
    }
}

struct CompraFila: View {
    let compra: Compra
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack { Text(compra.producto?.nombre ?? "Producto").font(.headline); Spacer(); Text(compra.estado).font(.caption).foregroundStyle(compra.estado == "Aprobada" ? .green : compra.estado == "Pendiente" ? .orange : .red) }
            Text("\(compra.proveedor?.nombre ?? "Proveedor") · \(compra.cantidad) × \(dinero(compra.costoUnitario))")
            Text("\(dinero(compra.total)) · \(compra.fecha.formatted(date: .abbreviated, time: .omitted))").foregroundStyle(.secondary)
            if let motivo = compra.motivoRechazo, !motivo.isEmpty { Text("Motivo: \(motivo)").foregroundStyle(.red) }
        }.font(.subheadline)
    }
}

struct MisComprasView: View {
    let usuario: Usuario
    @Query(sort: \Compra.fecha, order: .reverse) private var compras: [Compra]
    @State private var filtro = "Todas"
    var visibles: [Compra] { compras.filter { $0.comprador == usuario && (filtro == "Todas" || (filtro == "Pendientes" && $0.estado == "Pendiente") || (filtro == "Rechazadas" && $0.estado == "Rechazada")) } }
    var body: some View {
        VStack {
            Picker("Estado", selection: $filtro) { ForEach(["Todas", "Pendientes", "Rechazadas"], id: \.self) { Text($0) } }.pickerStyle(.segmented).padding(.horizontal)
            List(visibles) { CompraFila(compra: $0) }
        }.navigationTitle("Mis compras").toolbar { CuentaMenu() }
    }
}

struct AprobarView: View {
    @Environment(\.modelContext) private var contexto
    @Query(sort: \Compra.fecha, order: .reverse) private var compras: [Compra]
    @State private var rechazar: Compra?
    @State private var motivo = ""
    @State private var error = ""
    var body: some View {
        List(compras.filter { $0.estado == "Pendiente" }) { compra in
            VStack(alignment: .leading, spacing: 8) {
                CompraFila(compra: compra)
                Text("Solicitada por: \(compra.comprador?.nombre ?? "—")")
                if let p = compra.producto {
                    let stock = p.stock + compra.cantidad
                    let promedio = stock > 0 ? (Double(p.stock) * p.costoPromedio + Double(compra.cantidad) * compra.costoUnitario) / Double(stock) : 0
                    Text("Stock: \(p.stock) → \(stock)")
                    Text("Costo promedio: \(dinero(p.costoPromedio)) → \(dinero(promedio))")
                }
                HStack {
                    Button("Rechazar", role: .destructive) { motivo = ""; rechazar = compra }
                    Spacer()
                    Button("Aprobar") { aprobar(compra) }.buttonStyle(.borderedProminent)
                }
            }.padding(.vertical, 6)
        }
        .navigationTitle("Por aprobar").toolbar { CuentaMenu() }
        .sheet(item: $rechazar) { compra in
            NavigationStack {
                Form { Section("Motivo obligatorio") { TextField("Motivo del rechazo", text: $motivo, axis: .vertical) } }
                    .navigationTitle("Rechazar compra")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) { Button("Cancelar") { rechazar = nil } }
                        ToolbarItem(placement: .confirmationAction) { Button("Rechazar") { compra.estado = "Rechazada"; compra.motivoRechazo = motivo.trimmingCharacters(in: .whitespacesAndNewlines); guardar(); rechazar = nil }.disabled(motivo.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) }
                    }
            }.presentationDetents([.medium, .large])
        }
        .alert("Error", isPresented: Binding(get: { !error.isEmpty }, set: { if !$0 { error = "" } })) { Button("Aceptar", role: .cancel) {} } message: { Text(error) }
    }
    private func aprobar(_ compra: Compra) { guard compra.estado == "Pendiente" else { return }; compra.aplicarInventario(); compra.estado = "Aprobada"; guardar() }
    private func guardar() { do { try contexto.save() } catch { contexto.rollback(); self.error = "No se pudo guardar la operación." } }
}

struct PagosView: View {
    @Environment(\.modelContext) private var contexto
    @Query(sort: \Compra.fecha, order: .reverse) private var compras: [Compra]
    @State private var filtro = "Pendientes"
    @State private var busqueda = ""
    @State private var error = ""
    var visibles: [Compra] { compras.filter { compra in
        compra.estado == "Aprobada" && compra.alCredito && (busqueda.isEmpty || (compra.proveedor?.nombre.localizedCaseInsensitiveContains(busqueda) ?? false)) && (filtro == "Pagadas" ? compra.pagada : filtro == "Vencidas" ? compra.vencida : !compra.pagada)
    } }
    var totalPorPagar: Double { compras.filter { $0.estado == "Aprobada" && $0.alCredito && !$0.pagada }.reduce(0) { $0 + $1.total } }
    var body: some View {
        VStack {
            Picker("Estado", selection: $filtro) { ForEach(["Pendientes", "Vencidas", "Pagadas"], id: \.self) { Text($0) } }.pickerStyle(.segmented).padding(.horizontal)
            List {
                Section { LabeledContent("Total por pagar", value: dinero(totalPorPagar)) }
                ForEach(visibles) { compra in
                    VStack(alignment: .leading) {
                        CompraFila(compra: compra)
                        Text("Vence: \(compra.vence.formatted(date: .abbreviated, time: .omitted))")
                        if compra.vencida { Text("VENCIDA").font(.caption.bold()).foregroundStyle(.red) }
                    }.swipeActions { if !compra.pagada { Button("Pagar") { compra.pagada = true; do { try contexto.save() } catch { contexto.rollback(); self.error = "No se pudo registrar el pago." } }.tint(.green) } }
                }
            }
        }.navigationTitle("Por pagar").searchable(text: $busqueda, prompt: "Buscar proveedor").toolbar { CuentaMenu() }
        .alert("Error", isPresented: Binding(get: { !error.isEmpty }, set: { if !$0 { error = "" } })) { Button("Aceptar", role: .cancel) {} } message: { Text(error) }
    }
}
