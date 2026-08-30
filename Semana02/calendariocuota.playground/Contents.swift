
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
