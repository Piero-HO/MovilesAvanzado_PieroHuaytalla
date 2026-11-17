import SwiftUI
import SwiftData
import Charts

struct ResumenView: View {
    @Query private var productos: [Producto]
    @Query private var proveedores: [Proveedor]
    @Query private var compras: [Compra]
    var aprobadas: [Compra] { compras.filter { $0.estado == "Aprobada" } }
    var pendientes: [Compra] { compras.filter { $0.estado == "Pendiente" } }
    var body: some View {
        List {
            Section("Indicadores") {
                LabeledContent("Valor del inventario", value: dinero(productos.reduce(0) { $0 + Double($1.stock) * $1.costoPromedio }))
                LabeledContent("Crédito fiscal (IGV)", value: dinero(aprobadas.reduce(0) { $0 + $1.igv }))
                LabeledContent("Por pagar", value: dinero(aprobadas.filter { $0.alCredito && !$0.pagada }.reduce(0) { $0 + $1.total }))
                LabeledContent("Compras por aprobar", value: "\(pendientes.count) · \(dinero(pendientes.reduce(0) { $0 + $1.total }))")
            }
            Section("Compras por proveedor") {
                if proveedores.isEmpty { Text("Aún no hay proveedores.").foregroundStyle(.secondary) }
                else {
                    Chart(proveedores) { proveedor in
                        let total = proveedor.compras.filter { $0.estado == "Aprobada" }.reduce(0) { $0 + $1.total }
                        BarMark(x: .value("Total", total), y: .value("Proveedor", proveedor.nombre))
                    }.frame(height: CGFloat(max(160, proveedores.count * 45)))
                }
            }
        }.navigationTitle("Resumen").toolbar { CuentaMenu() }
    }
}
