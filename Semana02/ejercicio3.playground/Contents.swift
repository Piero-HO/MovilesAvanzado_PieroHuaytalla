import Foundation

// ===== EJERCICIO 3: FOR-IN =====
// --- Ejemplo (ya resuelto): ---
// Imprime los números del 1 al 5:
for i in 1...5 {
print("Número: \(i)")
}

// --- TODO 7: Tabla de multiplicar del 7 ---
// Imprime: 7 x 1 = 7, 7 x 2 = 14, ... 7 x 12 = 84
for i in 1...12 {
print("7 x \(i) = \(i * 7)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---
// Suma todos los números del 1 al 100
var suma = 0
for i in 1...100 {
suma = suma + i
}
print("La suma del 1 al 100 es: \(suma)") // Debe dar 5050

// --- TODO 9: Calcular el factorial de 8 ---
// Factorial: 8! = 8 × 7 × 6 × 5 × 4 × 3 × 2 × 1 = 40320
var factorial = 1
for i in 1...8 {
factorial = factorial * i
}
print("8! = \(factorial)")

// --- TODO 10: Patrón de asteriscos ---
// Imprime este patrón usando for anidados:
// *
// **
// ***
// ****
// *****
// Pista: usa String(repeating: "*", count: i)

var i: Int = 1
while i <= 5 {
    print(String(repeating: "*", count: i))
    i += 1
}


// ===== FIX: Encuentra los 2 errores =====

// Se quiere imprimir los números pares del 2 al 20:
for i in 1...20 {
    if i % 2 == 0 {         // FIX 4: ¿Imprime pares o impares?
        print(i)            // pares, se cambio a 0 el 1 en if i % 2 == ___
    }
}

// Se quiere contar del 10 al 1 (cuenta regresiva):
for i in stride(from: 10, through: 1, by: -1) { // FIX 5: ¿Cuenta hacia adelante o atrás?
    print(i)            // Cuenta hacua atras
}
// Pista: busca "stride" en Swift


// PREDICT: ¿Cuántas veces se ejecuta y qué imprime al final?

var total = 0
for i in 1...5 {
    total += i
}
print(total)    // PREDICT 6: ¿Valor? 15 ¿Cuántas iteraciones? 5 iteraciones en el que se suman

var texto = ""
for _ in 1...3 {
    texto += "Hola "
}
print(texto)    // PREDICT 7: Hola Hola Hola
// ¿Para qué sirve _ en vez de i?
// Sirve como comodin cuando no vamos a utilizar la variable dentro del bucle
