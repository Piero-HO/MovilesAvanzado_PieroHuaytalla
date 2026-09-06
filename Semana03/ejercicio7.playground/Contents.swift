// Desarrollado por: Piero Huaytalla
// Importamos la librería Foundation para operaciones del sistema y lectura
import Foundation

// Diccionario para almacenar el precio de cada producto usando su nombre como clave
var preciosProductos: [String: Double] = [:]
// Diccionario para almacenar el stock de cada producto usando su nombre como clave
var stocksProductos: [String: Int] = [:]

// Solicitamos al usuario la cantidad inicial de productos a registrar
print("¿Cuántos productos registrará inicialmente?")
// Leemos la entrada y la convertimos a entero de manera segura
let cantidadInicial = Int(readLine() ?? "") ?? 0

// Bucle para capturar los datos de cada uno de los N productos
for i in 1...cantidadInicial {
    // Pedimos el nombre del producto
    print("\nProducto \(i) - Nombre:")
    // Leemos el nombre protegiéndolo de valores nulos
    let nombre = readLine() ?? ""
    // Pedimos el precio del producto
    print("Precio unitario:")
    // Convertimos la entrada a Double con valor por defecto 0.0
    let precio = Double(readLine() ?? "") ?? 0.0
    // Pedimos la cantidad en inventario
    print("Stock disponible:")
    // Convertimos la entrada a Int con valor por defecto 0
    let stock = Int(readLine() ?? "") ?? 0
    
    // Asignamos el precio al diccionario usando el nombre como clave
    preciosProductos[nombre] = precio
    // Asignamos el stock al diccionario usando el nombre como clave
    stocksProductos[nombre] = stock
}

// Variable de control para el ciclo interactivo del menú
var continuar = true

// Bucle while para mantener el menú activo hasta que el usuario decida salir
while continuar {
    // Imprimimos la cabecera visual del menú
    print("\n================== MENÚ DE INVENTARIO ==================")
    // Imprimimos la opción 1
    print("1) Ver inventario")
    // Imprimimos la opción 2
    print("2) Buscar")
    // Imprimimos la opción 3
    print("3) Stock bajo")
    // Imprimimos la opción 4
    print("4) Valor total")
    // Imprimimos la opción 5
    print("5) Salir")
    // Solicitamos la elección del usuario
    print("Seleccione una opción (1-5):")
    
    // Leemos la opción elegida desde la consola
    let opcion = readLine() ?? ""
    
    // Evaluamos la opción con una estructura switch
    switch opcion {
    // Opción 1: Listar todos los productos
    case "1":
        // Mostramos el título de la sección
        print("\n---------------- INVENTARIO ACTUAL ----------------")
        // Validamos si no se han registrado productos
        if preciosProductos.isEmpty {
            // Informamos que la colección no tiene elementos
            print("El inventario está actualmente vacío.")
        // Bloque cuando sí existen registros
        } else {
            // Recorremos el diccionario de precios obteniendo nombre y precio
            for (nombre, precio) in preciosProductos {
                // Obtenemos el stock asociado con valor por defecto 0
                let stock = stocksProductos[nombre] ?? 0
                // Calculamos el valor acumulado de ese producto en almacén
                let subtotal = precio * Double(stock)
                // Imprimimos la fila formateada del producto
                print("• \(nombre) | Precio: S/. \(precio) | Stock: \(stock) und | Subtotal: S/. \(subtotal)")
            }
        }
        
    // Opción 2: Buscar producto por nombre
    case "2":
        // Pedimos el nombre del producto a consultar
        print("\nIngrese el nombre del producto a buscar:")
        // Leemos el texto de búsqueda
        let busqueda = readLine() ?? ""
        // Buscamos de forma segura en el diccionario con desempaquetado opcional
        if let precio = preciosProductos[busqueda] {
            // Obtenemos el stock asociado a la clave encontrada
            let stock = stocksProductos[busqueda] ?? 0
            // Mostramos los datos completos del producto encontrado
            print("✅ Encontrado: \(busqueda) -> Precio: S/. \(precio), Stock: \(stock) unidades.")
        // Bloque si la clave no existe en el diccionario
        } else {
            // Informamos que no se encontró el producto
            print("❌ El producto '\(busqueda)' no se encuentra en el inventario.")
        }
        
    // Opción 3: Mostrar productos con existencias menores a 5
    case "3":
        // Mostramos el encabezado del filtro de alertas
        print("\n---------------- PRODUCTOS CON STOCK BAJO (< 5) ----------------")
        // Bandera booleana para verificar si hubo productos en riesgo
        var hayAlertas = false
        // Recorremos el diccionario de existencias
        for (nombre, stock) in stocksProductos {
            // Evaluamos si el stock es estrictamente menor a 5
            if stock < 5 {
                // Obtenemos el precio unitario del producto filtrado
                let precio = preciosProductos[nombre] ?? 0.0
                // Mostramos el mensaje de advertencia del ítem
                print("⚠️ ALERTA: \(nombre) | Stock crítico: \(stock) und | Precio: S/. \(precio)")
                // Cambiamos el estado de la bandera indicando que sí hubo registros
                hayAlertas = true
            }
        }
        // Validamos si ningún producto cumplió la condición de stock crítico
        if !hayAlertas {
            // Informamos que todos los productos tienen stock seguro
            print("Todos los productos cuentan con 5 o más unidades en stock.")
        }
        
    // Opción 4: Calcular el valor financiero global del inventario
    case "4":
        // Variable acumuladora para almacenar la suma total en soles
        var valorTotal = 0.0
        // Recorremos todos los productos para acumular sus subtotales
        for (nombre, precio) in preciosProductos {
            // Obtenemos el stock de cada producto
            let stock = stocksProductos[nombre] ?? 0
            // Acumulamos el producto de precio por unidades al total global
            valorTotal += (precio * Double(stock))
        }
        // Imprimimos el encabezado del cálculo financiero
        print("\n---------------- VALOR TOTAL DEL INVENTARIO ----------------")
        // Mostramos el total económico calculado
        print("El valor monetario total del inventario es: S/. \(valorTotal)")
        
    // Opción 5: Finalizar el ciclo del menú
    case "5":
        // Mensaje informativo de despedida
        print("\nSaliendo del sistema de inventario. ¡Hasta pronto!")
        // Cambiamos la bandera a false para romper el bucle while
        continuar = false
        
    // Bloque para manejar opciones no contempladas en el menú
    default:
        // Mensaje de advertencia para entradas fuera del rango 1-5
        print("\n⚠️ Opción no válida. Por favor, elija un número del 1 al 5.")
    }
}
