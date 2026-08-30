
import Foundation // Importamos Foundation para tener acceso a Calendar, Date y String(format:)

// ==========================================
// 1. DEFINICIÓN DE LOS DATOS DE ENTRADA
// ==========================================
// Utilizamos 'let' para valores que no van a cambiar (constantes)
let nombreProducto = "MacBook Pro"
let precioUnitario: Double = 3500.00
let cantidad: Int = 1

// Calculamos el monto total multiplicando precio por cantidad
let montoCompra: Double = precioUnitario * Double(cantidad)

// Datos del plan de financiamiento
let planPagoMeses: Int = 12         // Meses del plan (6, 12 o 24)
let mesAdelanto: Int = 3            // En qué mes se hará el pago extra
let montoAdicional: Double = 1000.00 // Monto extra que se pagará en ese mes

// ==========================================
// 2. VALIDACIÓN DEL PLAN DE PAGO
// ==========================================
// Creamos un arreglo con los planes permitidos
let planesValidos = [6, 12, 24]

// Usamos 'contains' para verificar si el plan ingresado es válido
if !planesValidos.contains(planPagoMeses) {
    print("Error: El plan de pago de \(planPagoMeses) meses no es válido. Solo se aceptan 6, 12 o 24.")
} else {
    
    // ==========================================
    // 3. PREPARACIÓN DE VARIABLES PARA EL BUCLE
    // ==========================================
    // Calculamos el pago base dividiendo el total entre los meses
    let pagoBaseMensual = montoCompra / Double(planPagoMeses)
    
    // 'restaPorPagar' es una variable ('var') porque irá disminuyendo con cada pago
    var restaPorPagar = montoCompra
    
    // Contador para saber cuántos meses se pagaron realmente (por si se termina de pagar antes)
    var mesesPagadosRealmente = 0
    
    // ==========================================
    // 4. CONFIGURACIÓN DE FECHAS
    // ==========================================
    // DateFormatter nos permite convertir objetos Date a String con el formato que queramos
    let formateadorFecha = DateFormatter()
    formateadorFecha.dateFormat = "dd/MM/yyyy"
    
    // Definimos la fecha de hoy para calcular los próximos meses (Ej: 26 de agosto de 2026)
    let calendario = Calendar.current
    var componentes = DateComponents(year: 2026, month: 8, day: 26)
    let fechaInicio = calendario.date(from: componentes) ?? Date()
    // ==========================================
        // 5. IMPRESIÓN DE LA CABECERA
        // ==========================================
        print("Nombre Producto: \(nombreProducto)")
        print(String(format: "Precio Unitario: S/ %.2f", precioUnitario))
        print("Cantidad: \(cantidad)")
        print(String(format: "Monto de la compra: S/ %.2f", montoCompra))
        print("Plan de pago: \(planPagoMeses) meses")
        print("Mes de pago adelantado (0=ninguno): \(mesAdelanto)")
        print(String(format: "Monto adicional a pagar ese mes: S/ %.2f", montoAdicional))
        print("\n============ plan de pago =========")
        print("mes\tfecha\t\tmonto inicial\tpago\t\tresta por pagar")
        
        // ==========================================
        // 6. SIMULACIÓN DE LOS PAGOS (BUCLE)
        // ==========================================
        // Iteramos desde el mes 1 hasta el mes que indique el plan (ej. de 1 a 12)
        for mesActual in 1...planPagoMeses {
            
            // Condición de salida: Si la deuda es 0 o menor, rompemos el bucle 'for' para no seguir cobrando
            if restaPorPagar <= 0.01 { // Usamos 0.01 para evitar problemas de precisión de decimales
                break
            }
            
            // Sumamos 'mesActual' cantidad de meses a la fecha de inicio
            // Usamos 'guard let' porque la función date(byAdding:) devuelve un valor Opcional
            guard let fechaDePago = calendario.date(byAdding: .month, value: mesActual, to: fechaInicio) else {
                break // Si falla el cálculo de la fecha, salimos del bucle
            }
            // Convertimos la fecha calculada a un String legible
            let fechaString = formateadorFecha.string(from: fechaDePago)
            
            // El monto inicial de este mes es lo que restaba por pagar en el mes anterior
            let montoInicialDelMes = restaPorPagar
            
            // Empezamos asumiendo que el cliente pagará su cuota base normal
            var pagoDeEsteMes = pagoBaseMensual
            
            // Verificamos si estamos en el mes en el que el cliente prometió un adelanto
            if mesActual == mesAdelanto {
                pagoDeEsteMes += montoAdicional // Sumamos el extra a la cuota base
            }
