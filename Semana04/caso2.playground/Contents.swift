// Desarrollado por: Piero Huaytalla
// Importamos Foundation para utilidades estándar del lenguaje
import Foundation

// Definimos el enum para representar los dos estados posibles de un libro
enum EstadoLibro {
    // Estado cuando el libro está en estantería para préstamo
    case disponible
    // Estado cuando el libro ha sido retirado por un usuario
    case prestado
}

// Modelamos el libro como struct (tipo de valor) para encapsular sus datos
struct Libro {
    // Almacena el nombre del libro de forma inmutable
    let titulo: String
    // Almacena el autor de la obra de forma inmutable
    let autor: String
    // Variable con estado inicial disponible que cambiará según préstamos
    var estado: EstadoLibro = .disponible
}

// Creamos Biblioteca como class (tipo de referencia) para compartir la misma fuente de verdad
class Biblioteca {
    // Colección dinámica que mantiene el catálogo de libros
    var libros: [Libro] = []
    
    // Función para incorporar un nuevo libro a la colección
    func agregar(libro: Libro) {
        // Agregamos la instancia recibida al final del array de libros
        libros.append(libro)
    }
    
    // Función para gestionar la salida de un libro por su título
    func prestar(titulo: String) -> Bool {
        // Iteramos por índice numérico para poder mutar el elemento original del array
        for i in 0..<libros.count {
            // Evaluamos si el título del elemento coincide con el solicitado
            if libros[i].titulo == titulo {
                // Validamos que el ejemplar no esté prestado previamente
                if libros[i].estado == .disponible {
                    // Modificamos el struct DENTRO del array (una copia local no alteraría el inventario)
                    libros[i].estado = .prestado
                    // Notificamos en consola el préstamo concedido
                    print("Préstamo aprobado: \(titulo)")
                    // Finalizamos la ejecución retornando verdadero
                    return true
                // Rama condicional si el ejemplar ya fue prestado
                } else {
                    // Mostramos el mensaje de error por libro no disponible
                    print("Error: \(titulo) ya está prestado")
                    // Finalizamos retornando falso ante el préstamo fallido
                    return false
                }
            }
        }
        // Si el ciclo concluye sin coincidencias, informamos la inexistencia del título
        print("Error: no existe \(titulo)")
        // Retornamos falso indicando que no se pudo procesar
        return false
    }
    
    // Función para registrar el retorno de un ejemplar a la biblioteca
    func devolver(titulo: String) -> Bool {
        // Recorremos el catálogo mediante índices para modificar la posición exacta
        for i in 0..<libros.count {
            // Verificamos si encontramos el título indicado
            if libros[i].titulo == titulo {
                // Comprobamos que el libro efectivamente esté en condición de prestado
                if libros[i].estado == .prestado {
                    // Mutamos directamente el elemento en el array devolviéndolo a disponible
                    libros[i].estado = .disponible
                    // Imprimimos la confirmación de la devolución
                    print("Devolución registrada: \(titulo)")
                    // Retornamos verdadero tras la operación exitosa
                    return true
                // Rama si el libro ya figuraba como disponible
                } else {
                    // Informamos que el libro no requería devolución
                    print("Error: \(titulo) no estaba prestado")
                    // Retornamos falso al no proceder la devolución
                    return false
                }
            }
        }
        // Si no se localiza el libro en el array, imprimimos el mensaje de error
        print("Error: no existe \(titulo)")
        // Devolvemos falso por elemento no encontrado
        return false
    }
    
    // Función para imprimir el listado completo y su situación actual
    func inventario() {
        // Desplegamos el título delimitador del reporte
        print("===== INVENTARIO =====")
        // Recorremos cada instancia contenida en la lista de libros
        for libro in libros {
            // Variable temporal para guardar la cadena textual del estado
            var textoEstado = ""
            // Evaluamos exhaustivamente el estado mediante un switch
            switch libro.estado {
            // Caso en el que el libro puede solicitarse
            case .disponible:
                // Asignamos la palabra descriptiva disponible
                textoEstado = "disponible"
            // Caso en el que el libro está en préstamo
            case .prestado:
                // Asignamos la palabra descriptiva prestado
                textoEstado = "prestado"
            }
            // Imprimimos la línea formateada con título, autor y su estado actual
            print("\(libro.titulo) (\(libro.autor)) - \(textoEstado)")
        }
    }
}

// Inicializamos la instancia principal de la biblioteca
let biblioteca = Biblioteca()

// Agregamos el primer libro de prueba
biblioteca.agregar(libro: Libro(titulo: "Cien años de soledad", autor: "Gabriel García Márquez"))
// Agregamos el segundo libro de prueba
biblioteca.agregar(libro: Libro(titulo: "La ciudad y los perros", autor: "Mario Vargas Llosa"))
// Agregamos el tercer libro de prueba
biblioteca.agregar(libro: Libro(titulo: "El Quijote", autor: "Miguel de Cervantes"))

// Solicitamos el préstamo inicial de La ciudad y los perros
_ = biblioteca.prestar(titulo: "La ciudad y los perros")
// Forzamos un segundo préstamo del mismo libro para validar la advertencia
_ = biblioteca.prestar(titulo: "La ciudad y los perros")
// Devolvemos el libro prestado para restaurar su estado
_ = biblioteca.devolver(titulo: "La ciudad y los perros")
// Prestamos exitosamente El Quijote
_ = biblioteca.prestar(titulo: "El Quijote")
// Intentamos prestar un libro no registrado para comprobar el manejo de errores
_ = biblioteca.prestar(titulo: "El Principito")

// Mostramos la salida del inventario final consolidado
biblioteca.inventario()
