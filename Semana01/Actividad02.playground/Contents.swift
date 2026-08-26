import Foundation

// peso de notas
let pesoParcial = 0.3
let pesoFinal = 0.4
let pesoLaboratorio = 0.3

print("Nombre del alumno:")
let alumno = readLine() ?? ""
print("Nota del examen parcial (30%):")
let parcial = Double(readLine() ?? "0") ?? 0
print("Nota de Laboratorio (30%)")
let laboratorio = Double(readLine() ?? "0") ?? 0
print("Nota del examen final (40%)")
let final = Double(readLine() ?? "0") ?? 0
// promedio
let promedio = parcial * pesoParcial + laboratorio * pesoLaboratorio + final * pesoFinal

//observacion
var observacion = ""
if promedio >= 18 {
    observacion = "Sobresaliente"
} else if promedio >= 15{
    observacion = "Bueno"
}else if promedio >= 13{
    observacion = "Aprobado"
}else {
    observacion = "Reprobado"
}
print("")
print("\(alumno) obtuvo un promedio de \(promedio)")
print("\(alumno) esta \(observacion)")
