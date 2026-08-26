import Foundation

// calendario de pagos
// ingresar el nombre del producto, precio, cantidad
let igv = 0.18
func CalcularDescuento(cantidad: Int, subtotal: Double)->Double{
    if cantidad > 10{
        return subtotal * 0.15
    }else if cantidad > 5 {
        return subtotal * 0.10
    }else {
        return 0.0
    }
}
print("ingrese el nombre del producto")
let producto = readLine() ?? ""
print("ingrese el precio del producto")
let precio = Double(readLine() ?? "0") ?? 0.0
print("ingrese la cantidad de producto")
let cantidad = Int(readLine() ?? "0") ?? 0

let subtotal = precio * Double(cantidad)
let descuento = CalcularDescuento(cantidad: cantidad, subtotal: subtotal)
//hallar el montobase : subtotal - descuento
//hallar el igv : montobase * igv
//total : montobase + igv
//commt
//mostrar los datos
