import Foundation

// ===== EJERCICIO 6: CARRITO MEJORADO CON IA =====
// Docente: Juan León S.

// Definición de datos de entrada para los productos
let p1Nombre = "Laptop"; let p1Precio = 3500.0; let p1Cantidad = 1 // Asigna datos de la laptop: nombre, precio unitario y cantidad
let p2Nombre = "Mouse"; let p2Precio = 45.50; let p2Cantidad = 2 // Asigna datos del mouse: nombre, precio unitario y cantidad
let p3Nombre = "Teclado"; let p3Precio = 120.00; let p3Cantidad = 1 // Asigna datos del teclado: nombre, precio unitario y cantidad
let p4Nombre = "Monitor"; let p4Precio = 890.00; let p4Cantidad = 1 // Asigna datos del monitor: nombre, precio unitario y cantidad
let p5Nombre = "USB Cable"; let p5Precio = 15.00; let p5Cantidad = 3 // Asigna datos del cable USB con 3 unidades para descuento

// Requisito 5: Validación de precios negativos o cantidades cero
let hayErrorPrecios = p1Precio < 0 || p2Precio < 0 || p3Precio < 0 || p4Precio < 0 || p5Precio < 0 // Evalúa si existe algún precio menor a cero
let hayErrorCantidades = p1Cantidad <= 0 || p2Cantidad <= 0 || p3Cantidad <= 0 || p4Cantidad <= 0 || p5Cantidad <= 0 // Evalúa si alguna cantidad es menor o igual a cero

if hayErrorPrecios || hayErrorCantidades { // Comprueba si ocurrió cualquier error de validación
    print("Error: Existen datos inválidos en los precios o cantidades de los productos.") // Emite mensaje de alerta si falla la validación
} else { // Ejecuta los cálculos si todos los datos ingresados son válidos
    // Requisito 1: Descuento por cantidad (5% extra si la cantidad >= 3)
    let p1FactorDesc = p1Cantidad >= 3 ? 0.95 : 1.0 // Aplica 5% de descuento al producto 1 si se compran 3 o más unidades
    let p2FactorDesc = p2Cantidad >= 3 ? 0.95 : 1.0 // Aplica 5% de descuento al producto 2 si se compran 3 o más unidades
    let p3FactorDesc = p3Cantidad >= 3 ? 0.95 : 1.0 // Aplica 5% de descuento al producto 3 si se compran 3 o más unidades
    let p4FactorDesc = p4Cantidad >= 3 ? 0.95 : 1.0 // Aplica 5% de descuento al producto 4 si se compran 3 o más unidades
    let p5FactorDesc = p5Cantidad >= 3 ? 0.95 : 1.0 // Aplica 5% de descuento al producto 5 si se compran 3 o más unidades

    let p1Subtotal = (p1Precio * Double(p1Cantidad)) * p1FactorDesc // Calcula subtotal final de laptops con posible descuento por volumen
    let p2Subtotal = (p2Precio * Double(p2Cantidad)) * p2FactorDesc // Calcula subtotal final de mouse con posible descuento por volumen
    let p3Subtotal = (p3Precio * Double(p3Cantidad)) * p3FactorDesc // Calcula subtotal final de teclados con posible descuento por volumen
    let p4Subtotal = (p4Precio * Double(p4Cantidad)) * p4FactorDesc // Calcula subtotal final de monitores con posible descuento por volumen
    let p5Subtotal = (p5Precio * Double(p5Cantidad)) * p5FactorDesc // Calcula subtotal final de cables USB aplicando el descuento del 5%

    let subtotalBruto = p1Subtotal + p2Subtotal + p3Subtotal + p4Subtotal + p5Subtotal // Suma los subtotales de todos los artículos

    // Requisito 2: Cupón de descuento "DESCUENTO20" (20% adicional)
    let cuponIngresado = "DESCUENTO20" // Define el código promocional ingresado por el usuario
    let porcentajeCupon = cuponIngresado == "DESCUENTO20" ? 0.20 : 0.0 // Asigna 20% si coincide el cupón o 0% si es incorrecto
    let montoAhorroCupon = subtotalBruto * porcentajeCupon // Calcula el monto en dinero descontado por el cupón
    let subtotalConCupon = subtotalBruto - montoAhorroCupon // Resta el descuento promocional del subtotal acumulado

    // Cálculo de impuesto IGV (18%)
    let impuestoIgv = subtotalConCupon * 0.18 // Calcula el 18% del Impuesto General a las Ventas sobre el monto con descuento
    let totalMercaderia = subtotalConCupon + impuestoIgv // Calcula el costo total de los productos con impuestos incluidos

    // Requisito 3: Envío gratis si total > S/. 3000, sino S/. 25.00
    let costoEnvio = totalMercaderia > 3000.0 ? 0.0 : 25.0 // Asigna costo de envío gratis o tarifa estándar según el monto
    let totalPagarFinal = totalMercaderia + costoEnvio // Suma el envío al total para obtener el valor final a pagar

    // Requisito 4: Puntos de fidelidad (1 punto por cada S/. 100 de compra)
    let puntosFidelidadGanados = Int(totalPagarFinal / 100.0) // Calcula los puntos de lealtad obtenidos truncando la división a entero

    // Generación de línea divisoria
    var lineaGuiones = "" // Inicializa la cadena para el separador visual
    for _ in 1...48 { // Itera 48 veces para formar una línea uniforme
        lineaGuiones += "=" // Concatena el caracter igual en cada iteración
    }

    // Impresión del ticket enriquecido
    print("\n" + lineaGuiones) // Muestra la línea de encabezado superior
    print("        TICKET MEJORADO - TIENDA TECSUP") // Muestra el título principal del ticket de compra
    print(lineaGuiones) // Muestra separador horizontal
    print("\(p1Nombre) x\(p1Cantidad)\t\t\t\tS/. \(String(format: "%.2f", p1Subtotal))") // Imprime detalle formateado de laptops
    print("\(p2Nombre) x\(p2Cantidad)\t\t\t\tS/. \(String(format: "%.2f", p2Subtotal))") // Imprime detalle formateado de mouse
    print("\(p3Nombre) x\(p3Cantidad)\t\t\t\tS/. \(String(format: "%.2f", p3Subtotal))") // Imprime detalle formateado de teclado
    print("\(p4Nombre) x\(p4Cantidad)\t\t\t\tS/. \(String(format: "%.2f", p4Subtotal))") // Imprime detalle formateado de monitor
    print("\(p5Nombre) x\(p5Cantidad) (5% desc inc.)\t\tS/. \(String(format: "%.2f", p5Subtotal))") // Imprime detalle formateado del cable USB con aviso
    print(lineaGuiones) // Muestra separador horizontal
    print("Subtotal Bruto:\t\t\tS/. \(String(format: "%.2f", subtotalBruto))") // Imprime el subtotal de artículos
    print("Cupón (\(cuponIngresado)):\t\t-S/. \(String(format: "%.2f", montoAhorroCupon))") // Imprime el descuento por cupón
    print("IGV (18%):\t\t\tS/. \(String(format: "%.2f", impuestoIgv))") // Imprime el valor del impuesto
    print("Costo de Envío:\t\t\t\(costoEnvio == 0.0 ? "GRATIS" : "S/. \(costoEnvio)")") // Muestra si el envío fue gratuito o su costo
    print(lineaGuiones) // Muestra separador horizontal
    print("TOTAL A PAGAR:\t\t\tS/. \(String(format: "%.2f", totalPagarFinal))") // Muestra el valor absoluto a pagar
    print("Puntos Ganados:\t\t\t\(puntosFidelidadGanados) pts") // Muestra los puntos de fidelidad obtenidos en la compra
    print(lineaGuiones) // Muestra la línea de cierre inferior
}
