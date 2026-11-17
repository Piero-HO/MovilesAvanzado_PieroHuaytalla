import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(Sesion.self) private var sesion
    var body: some View {
        if let usuario = sesion.usuario { PrincipalView(usuario: usuario) }
        else { LoginView() }
    }
}

struct PrincipalView: View {
    let usuario: Usuario
    var body: some View {
        TabView {
            if usuario.rol == "Supervisor" {
                NavigationStack { ResumenView() }.tabItem { Label("Resumen", systemImage: "chart.bar") }
                NavigationStack { AprobarView() }.tabItem { Label("Aprobar", systemImage: "checkmark.seal") }
                NavigationStack { PagosView() }.tabItem { Label("Por pagar", systemImage: "creditcard") }
            }
            NavigationStack { ProductosView(supervisor: usuario.rol == "Supervisor") }.tabItem { Label("Productos", systemImage: "shippingbox") }
            NavigationStack { ProveedoresView(supervisor: usuario.rol == "Supervisor") }.tabItem { Label("Proveedores", systemImage: "building.2") }
            if usuario.rol == "Comprador" {
                NavigationStack { NuevaCompraView(usuario: usuario) }.tabItem { Label("Compra", systemImage: "cart.badge.plus") }
                NavigationStack { MisComprasView(usuario: usuario) }.tabItem { Label("Mis compras", systemImage: "list.bullet") }
            }
        }
    }
}

struct CuentaMenu: ToolbarContent {
    @Environment(Sesion.self) private var sesion
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                if let usuario = sesion.usuario {
                    Text(usuario.nombre); Text(usuario.rol)
                }
                Button("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right") { sesion.usuario = nil }
            } label: { Image(systemName: "person.crop.circle") }
        }
    }
}
