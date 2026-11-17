import SwiftUI
import SwiftData

struct ProductosView: View {
    let supervisor: Bool
    @Environment(\.modelContext) private var contexto
    @Query(sort: \Producto.nombre) private var productos: [Producto]
    @State private var busqueda = ""
    @State private var mostrar = false
    @State private var editando: Producto?
    @State private var error = ""
    var filtrados: [Producto] { busqueda.isEmpty ? productos : productos.filter { $0.nombre.localizedCaseInsensitiveContains(busqueda) || $0.categoria.localizedCaseInsensitiveContains(busqueda) } }
    var body: some View {
        List {
            Section { LabeledContent("Valor del inventario", value: dinero(productos.reduce(0) { $0 + Double($1.stock) * $1.costoPromedio })) }
            Section("Productos") {
                ForEach(filtrados) { producto in
                    Button { if supervisor { editando = producto } } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(producto.nombre).font(.headline); Text(producto.categoria).font(.caption).foregroundStyle(.secondary)
                                Text("Costo promedio: \(dinero(producto.costoPromedio))").font(.subheadline)
                            }
                            Spacer()
                            Text("Stock: \(producto.stock)").foregroundStyle(producto.stock > 10 ? .green : producto.stock > 5 ? .orange : .red)
                        }
                    }.buttonStyle(.plain)
                    .swipeActions {
                        if supervisor { Button("Eliminar", role: .destructive) { eliminar(producto) } }
                    }
                }
            }
        }
        .navigationTitle("Productos").searchable(text: $busqueda, prompt: "Buscar producto")
        .toolbar { CuentaMenu(); if supervisor { ToolbarItem(placement: .topBarTrailing) { Button("Agregar", systemImage: "plus") { mostrar = true } } } }
        .sheet(isPresented: $mostrar) { ProductoForm() }
        .sheet(item: $editando) { ProductoForm(producto: $0) }
        .alert("No se puede eliminar", isPresented: Binding(get: { !error.isEmpty }, set: { if !$0 { error = "" } })) { Button("Aceptar", role: .cancel) {} } message: { Text(error) }
    }
    private func eliminar(_ producto: Producto) {
        guard producto.compras.isEmpty else { error = "El producto tiene compras registradas."; return }
        contexto.delete(producto)
        do { try contexto.save() } catch { contexto.rollback(); self.error = "No se pudo eliminar el producto." }
    }
}

struct ProductoForm: View {
    var producto: Producto?
    @Environment(\.modelContext) private var contexto
    @Environment(\.dismiss) private var dismiss
    @State private var nombre = ""
    @State private var categoria = ""
    @State private var stock = "0"
    @State private var costo = "0"
    @State private var error = ""
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nombre", text: $nombre); TextField("Categoría", text: $categoria)
                TextField("Stock inicial", text: $stock).keyboardType(.numberPad)
                TextField("Costo promedio", text: $costo).keyboardType(.decimalPad)
                if !error.isEmpty { Text(error).foregroundStyle(.red) }
            }
            .navigationTitle(producto == nil ? "Nuevo producto" : "Editar producto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancelar") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) { Button("Guardar") { guardar() } }
            }
            .onAppear { if let producto { nombre = producto.nombre; categoria = producto.categoria; stock = String(producto.stock); costo = String(producto.costoPromedio) } }
        }
    }
    private func guardar() {
        let n = nombre.trimmingCharacters(in: .whitespacesAndNewlines), c = categoria.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !n.isEmpty, !c.isEmpty, let s = Int(stock), s >= 0, let p = Double(costo.replacingOccurrences(of: ",", with: ".")), p >= 0, p.isFinite else { error = "Completa los campos con valores válidos."; return }
        if let producto { producto.nombre = n; producto.categoria = c; producto.stock = s; producto.costoPromedio = p }
        else { contexto.insert(Producto(nombre: n, categoria: c, stock: s, costoPromedio: p)) }
        do { try contexto.save(); dismiss() } catch { contexto.rollback(); self.error = "No se pudo guardar el producto." }
    }
}

struct ProveedoresView: View {
    let supervisor: Bool
    @Environment(\.modelContext) private var contexto
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]
    @State private var busqueda = ""
    @State private var mostrar = false
    @State private var editando: Proveedor?
    @State private var error = ""
    var filtrados: [Proveedor] { busqueda.isEmpty ? proveedores : proveedores.filter { $0.nombre.localizedCaseInsensitiveContains(busqueda) || $0.ruc.localizedCaseInsensitiveContains(busqueda) } }
    var body: some View {
        List(filtrados) { proveedor in
            Button { if supervisor { editando = proveedor } } label: {
                VStack(alignment: .leading, spacing: 5) {
                    HStack { Text(proveedor.nombre).font(.headline); Spacer(); Text(proveedor.compras.contains { $0.estado == "Aprobada" && $0.alCredito && !$0.pagada } ? "Por pagar" : "Al día").font(.caption).foregroundStyle(.blue) }
                    Text("RUC: \(proveedor.ruc)").foregroundStyle(.secondary)
                    Text("Total comprado: \(dinero(proveedor.compras.filter { $0.estado == "Aprobada" }.reduce(0) { $0 + $1.total }))")
                }
            }.buttonStyle(.plain)
            .swipeActions { if supervisor { Button("Eliminar", role: .destructive) { eliminar(proveedor) } } }
        }
        .navigationTitle("Proveedores").searchable(text: $busqueda, prompt: "Buscar proveedor")
        .toolbar { CuentaMenu(); if supervisor { ToolbarItem(placement: .topBarTrailing) { Button("Agregar", systemImage: "plus") { mostrar = true } } } }
        .sheet(isPresented: $mostrar) { ProveedorForm() }.sheet(item: $editando) { ProveedorForm(proveedor: $0) }
        .alert("No se puede eliminar", isPresented: Binding(get: { !error.isEmpty }, set: { if !$0 { error = "" } })) { Button("Aceptar", role: .cancel) {} } message: { Text(error) }
    }
    private func eliminar(_ proveedor: Proveedor) {
        guard proveedor.compras.isEmpty else { error = "El proveedor tiene compras registradas."; return }
        contexto.delete(proveedor)
        do { try contexto.save() } catch { contexto.rollback(); self.error = "No se pudo eliminar el proveedor." }
    }
}

struct ProveedorForm: View {
    var proveedor: Proveedor?
    @Environment(\.modelContext) private var contexto
    @Environment(\.dismiss) private var dismiss
    @State private var nombre = ""
    @State private var ruc = ""
    @State private var error = ""
    var body: some View {
        NavigationStack {
            Form { TextField("Nombre", text: $nombre); TextField("RUC", text: $ruc).keyboardType(.numberPad); if !error.isEmpty { Text(error).foregroundStyle(.red) } }
                .navigationTitle(proveedor == nil ? "Nuevo proveedor" : "Editar proveedor")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) { Button("Cancelar") { dismiss() } }
                    ToolbarItem(placement: .confirmationAction) { Button("Guardar") { guardar() } }
                }
                .onAppear { if let proveedor { nombre = proveedor.nombre; ruc = proveedor.ruc } }
        }
    }
    private func guardar() {
        let n = nombre.trimmingCharacters(in: .whitespacesAndNewlines), r = ruc.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !n.isEmpty, !r.isEmpty else { error = "Completa nombre y RUC."; return }
        if let proveedor { proveedor.nombre = n; proveedor.ruc = r } else { contexto.insert(Proveedor(nombre: n, ruc: r)) }
        do { try contexto.save(); dismiss() } catch { contexto.rollback(); self.error = "No se pudo guardar el proveedor." }
    }
}
