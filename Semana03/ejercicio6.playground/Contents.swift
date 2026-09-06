// Desarrollado por: Piero Huaytalla
// Importamos Foundation para funciones del sistema y utilidades básicas
import Foundation

// Diccionario principal para almacenar el nombre como clave y un array de 3 notas como valor
var registroNotas: [String: [Double]] = [:]

// Solicitamos la cantidad de alumnos a ingresar
print("¿Cuántos alumnos desea registrar?")

// Leemos la cantidad desde la consola y la convertimos a entero con valor por defecto 0
let cantidadAlumnos = Int(readLine() ?? "") ?? 0

// Bucle para iterar la cantidad de alumnos ingresada
for i in 1...cantidadAlumnos {
    // Mostramos mensaje para pedir el nombre del alumno actual
    print("\nNombre del alumno \(i):")
    // Leemos el nombre asegurando que no sea nulo mediante coalescencia nula
    let nombre = readLine() ?? ""
    
    // Array temporal para almacenar las 3 notas del alumno
    var notasAlumno: [Double] = []
    
    // Bucle para solicitar exactamente 3 notas por cada estudiante
    for j in 1...3 {
        // Solicitamos el ingreso de cada nota individual
        print("  Ingrese nota \(j):")
        // Leemos la entrada, la convertimos a Double y si falla asignamos 0.0
        let nota = Double(readLine() ?? "") ?? 0.0
        // Agregamos la nota al array de notas del alumno
        notasAlumno.append(nota)
    }
    
    // Guardamos las 3 notas en el diccionario usando el nombre como clave
    registroNotas[nombre] = notasAlumno
}

// Array de tuplas para almacenar temporalmente el nombre, su promedio y su clasificación
var alumnosProcesados: [(nombre: String, promedio: Double, estado: String)] = []

// Variables acumuladoras para calcular las estadísticas globales del grupo
var sumaTodosPromedios = 0.0
// Variable para contar el total de estudiantes aprobados
var totalAprobados = 0
// Variable para registrar la nota individual más alta del grupo
var notaGlobalMaxima = 0.0
// Variable para registrar la nota individual más baja del grupo (inicializada alta)
var notaGlobalMinima = 20.0

// Recorremos cada registro del diccionario (nombre y su lista de notas)
for (nombre, notas) in registroNotas {
    // Variable para sumar las notas del alumno en curso
    var sumaNotasAlumno = 0.0
    
    // Iteramos por cada una de las notas del alumno
    for nota in notas {
        // Acumulamos cada nota para el cálculo del promedio
        sumaNotasAlumno += nota
        // Actualizamos la nota global más alta si la actual es mayor
        if nota > notaGlobalMaxima { notaGlobalMaxima = nota }
        // Actualizamos la nota global más baja si la actual es menor
        if nota < notaGlobalMinima { notaGlobalMinima = nota }
    }
    
    // Calculamos el promedio individual dividiendo la suma entre el total de notas (3)
    let promedioAlumno = sumaNotasAlumno / Double(notas.count)
    // Acumulamos el promedio al acumulador general de la clase
    sumaTodosPromedios += promedioAlumno
    
    // Variable para almacenar la clasificación según la escala de notas
    var estado = ""
    
    // Evaluamos el promedio con switch según el rango de calificación
    switch promedioAlumno {
    // Caso para notas sobresalientes entre 18 y 20
    case 18.0...20.0:
        estado = "Excelente"
    // Caso para notas buenas entre 15 y menores a 18
    case 15.0..<18.0:
        estado = "Bueno"
    // Caso para notas aprobadas entre 13 y menores a 15
    case 13.0..<15.0:
        estado = "Aprobado"
    // Caso por defecto para notas menores a 13
    default:
        estado = "Desaprobado"
    }
    
    // Si el promedio es 13 o más, incrementamos el contador de aprobados
    if promedioAlumno >= 13.0 {
        totalAprobados += 1
    }
    
    // Agregamos la tupla con los resultados calculados a la lista general
    alumnosProcesados.append((nombre: nombre, promedio: promedioAlumno, estado: estado))
}

// Ordenamos la lista de alumnos de mayor a menor según su promedio
alumnosProcesados.sort { $0.promedio > $1.promedio }

// Imprimimos la cabecera del reporte final ordenado
print("\n===== REPORTE DE ALUMNOS (ORDENADO POR PROMEDIO) =====")

// Recorremos la lista ordenada de tuplas para mostrar los resultados individuales
for alumno in alumnosProcesados {
    // Mostramos el nombre, promedio formateado a dos decimales y su clasificación
    print("Alumno: \(alumno.nombre) | Promedio: \(String(format: "%.2f", alumno.promedio)) | Estado: \(alumno.estado)")
}

// Calculamos el promedio global de toda la clase dividiendo entre la cantidad de alumnos
let promedioGeneral = cantidadAlumnos > 0 ? (sumaTodosPromedios / Double(cantidadAlumnos)) : 0.0
// Calculamos el porcentaje de aprobados respecto al total
let porcentajeAprobados = cantidadAlumnos > 0 ? ((Double(totalAprobados) / Double(cantidadAlumnos)) * 100.0) : 0.0

// Imprimimos la cabecera de las estadísticas generales
print("\n===== ESTADÍSTICAS GENERALES =====")
// Mostramos el promedio de toda la clase
print("Promedio general del aula: \(String(format: "%.2f", promedioGeneral))")
// Mostramos la nota más alta registrada entre todas las ingresadas
print("Nota más alta individual: \(notaGlobalMaxima)")
// Mostramos la nota más baja registrada entre todas las ingresadas
print("Nota más baja individual: \(notaGlobalMinima)")
// Mostramos el porcentaje final de alumnos que lograron aprobar
print("Porcentaje de aprobados: \(String(format: "%.1f", porcentajeAprobados))%")
