import Foundation

// ===== EJERCICIO 7: JUEGO DE ADIVINANZA CON IA =====
// Docente: Juan León S.

let numeroSecreto = 42 // Define el número secreto que el usuario debe adivinar

// Simulación de los 5 intentos mediante variables independientes
let intentoN1 = 20 // Primer valor ingresado para intentar adivinar
let intentoN2 = 50 // Segundo valor ingresado para intentar adivinar
let intentoN3 = 35 // Tercer valor ingresado para intentar adivinar
let intentoN4 = 42 // Cuarto valor ingresado para intentar adivinar
let intentoN5 = 10 // Quinto valor ingresado para intentar adivinar

var turnoActual = 1 // Controla el número de turno o iteración en curso
var haAdivinado = false // Bandera lógica que indica si el jugador adivinó el número
var intentosConsumidos = 0 // Contador acumulativo de los intentos realizados

print("\n================ MINI JUEGO: ADIVINANZA ================") // Imprime el encabezado decorativo del juego

while turnoActual <= 5 && !haAdivinado { // Ejecuta el bucle mientras queden intentos y no se haya ganado
    var valorEvaluado = 0 // Variable local que almacenará el intento según el turno

    if turnoActual == 1 { valorEvaluado = intentoN1 } // Asigna el primer intento al turno 1
    else if turnoActual == 2 { valorEvaluado = intentoN2 } // Asigna el segundo intento al turno 2
    else if turnoActual == 3 { valorEvaluado = intentoN3 } // Asigna el tercer intento al turno 3
    else if turnoActual == 4 { valorEvaluado = intentoN4 } // Asigna el cuarto intento al turno 4
    else if turnoActual == 5 { valorEvaluado = intentoN5 } // Asigna el quinto intento al turno 5

    intentosConsumidos += 1 // Incrementa el contador de intentos utilizados

    if valorEvaluado == numeroSecreto { // Evalúa si el número ingresado es idéntico al número secreto
        print("Intento \(turnoActual): [\(valorEvaluado)] -> ¡Correcto! Has ganado en \(intentosConsumidos) intentos.") // Mensaje de victoria
        haAdivinado = true // Cambia la bandera a verdadera para terminar el bucle
    } else if valorEvaluado < numeroSecreto { // Evalúa si el número ingresado es menor al secreto
        print("Intento \(turnoActual): [\(valorEvaluado)] -> Muy bajo.") // Pista indicando que el número es mayor
    } else { // Caso en que el número ingresado es mayor al secreto
        print("Intento \(turnoActual): [\(valorEvaluado)] -> Muy alto.") // Pista indicando que el número es menor
    }

    turnoActual += 1 // Avanza al siguiente turno de la simulación
}

if !haAdivinado { // Verifica si se terminaron los 5 turnos sin haber acertado
    print("Perdiste. El número era: \(numeroSecreto)") // Muestra mensaje de derrota indicando la respuesta correcta
}
print("=========================================================") // Cierre visual del juego
