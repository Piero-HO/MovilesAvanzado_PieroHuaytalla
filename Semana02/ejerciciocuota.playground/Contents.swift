import Foundation

print("Nombre del Producto")
let producto = readLine() ?? ""
print("Ingrese el Precio")
let precio = Double(readLine() ?? "") ?? 0
print("Ingrese la Cantidad")
let cantidad = Int(readLine() ?? "") ?? 0
let montoTotal = precio * Double(cantidad)
print("\nNombre del producto: \(producto)")
print("Precio unit: \(precio)")
print("Cantidad: \(cantidad)")
print("Monto total de la compra: \(montoTotal)")

print("Elige el plan de pago:")
print("6 (20%)")
print("12 (40%)")
print("24 (60%)")

let meses = Int(readLine() ?? "") ?? 0
var interes: Double = 0

switch meses {
case 6:
    interes = 0.20
case 12:
    interes = 0.40
case 24:
    interes = 0.60
default:
    print("Opcion no valida")
    exit(0)
}
let montoInteres = montoTotal * interes
let montoFinanciado = montoTotal + montoInteres
let cuotaMensual = montoFinanciado / Double(meses)

print("\n=================== Plan de pago ===================")
print("Producto: \(producto) \tInteres: \(interes * 100)%  \tCuota M: \(cuotaMensual)")
print("Monto compra: \(montoTotal) \tMonto finan: \(montoFinanciado)")

print("\nMes \tMonto Inicial \tCuota Mensual \tResta x Pago")
var saldo = montoFinanciado
for mes in 1...meses {
    print("\(mes) \t\(saldo) \t\t\(cuotaMensual) \t\t\(saldo - cuotaMensual)")
    saldo -= cuotaMensual
}
