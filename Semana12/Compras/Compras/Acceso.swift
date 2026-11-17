import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(Sesion.self) private var sesion
    @Query private var usuarios: [Usuario]
    @State private var usuario = ""
    @State private var clave = ""
    @State private var error = ""
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Image(systemName: "shippingbox.fill").font(.system(size: 54)).foregroundStyle(.blue).frame(maxWidth: .infinity)
                    Text("Compras").font(.largeTitle.bold()).frame(maxWidth: .infinity)
                }
                Section("Iniciar sesión") {
                    TextField("Usuario", text: $usuario).textInputAutocapitalization(.never).autocorrectionDisabled()
                    SecureField("Clave", text: $clave)
                    if !error.isEmpty { Text(error).foregroundStyle(.red) }
                    Button("Ingresar") {
                        if let encontrado = usuarios.first(where: { $0.usuario.caseInsensitiveCompare(usuario.trimmingCharacters(in: .whitespacesAndNewlines)) == .orderedSame && $0.clave == clave }) {
                            sesion.usuario = encontrado
                        } else { error = "Usuario o clave incorrectos" }
                    }
                    NavigationLink("Crear cuenta") { RegistroView() }
                }
            }
        }
    }
}

struct RegistroView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(Sesion.self) private var sesion
    @Query private var usuarios: [Usuario]
    @State private var nombre = ""
    @State private var usuario = ""
    @State private var clave = ""
    @State private var confirmacion = ""
    @State private var rol = "Comprador"
    @State private var error = ""
    var body: some View {
        Form {
            TextField("Nombre completo", text: $nombre)
            TextField("Usuario", text: $usuario).textInputAutocapitalization(.never).autocorrectionDisabled()
            SecureField("Clave (mínimo 6 caracteres)", text: $clave)
            SecureField("Confirmar clave", text: $confirmacion)
            Picker("Rol", selection: $rol) { Text("Comprador").tag("Comprador"); Text("Supervisor").tag("Supervisor") }
            if !error.isEmpty { Text(error).foregroundStyle(.red) }
            Button("Registrarme") { registrar() }
        }.navigationTitle("Crear cuenta")
    }
    private func registrar() {
        let n = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        let u = usuario.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !n.isEmpty, !u.isEmpty else { error = "Completa tu nombre y usuario"; return }
        guard !usuarios.contains(where: { $0.usuario.caseInsensitiveCompare(u) == .orderedSame }) else { error = "Este usuario ya existe"; return }
        guard clave.count >= 6 else { error = "La clave debe tener al menos 6 caracteres"; return }
        guard clave == confirmacion else { error = "Las claves no coinciden"; return }
        let nuevo = Usuario(nombre: n, usuario: u, clave: clave, rol: rol)
        contexto.insert(nuevo)
        do { try contexto.save(); sesion.usuario = nuevo } catch { contexto.rollback(); self.error = "No se pudo guardar la cuenta" }
    }
}
