# Prompts utilizados — Laboratorio 04

## Herramienta de IA utilizada
Gemini

## Caso 2B Biblioteca
### Prompt 1:
CONTEXTO: "Soy estudiante de Swift, cuarta semana, trabajo en un Playground de Xcode"
TAREA: "Necesito una biblioteca con enum EstadoLibro, struct Libro y class Biblioteca con prestar, devolver e inventario"
RESTRICCIONES: "Solo struct, class, herencia, protocolos, enums, arrays, bucles y funciones. Sin optionals ni guard let, sin firstIndex(where:), sin didSet, sin propiedades calculadas, sin genéricos. Recorrido por índice obligatorio para mutar el struct dentro del array. Cada línea con un comentario explicativo específico."
FORMATO: "Solo el código Swift, con las firmas exactas que te indico y comentarios línea por línea."
EJEMPLO: 
Préstamo aprobado: La ciudad y los perros
Error: La ciudad y los perros ya está prestado
Devolución registrada: La ciudad y los perros
Préstamo aprobado: El Quijote
Error: no existe El Principito
===== INVENTARIO =====
Cien años de soledad (Gabriel García Márquez) - disponible
La ciudad y los perros (Mario Vargas Llosa) - disponible
El Quijote (Miguel de Cervantes) - prestado

### Respuesta de la IA:
Generó la estructura completa con el enum EstadoLibro, el struct Libro y la clase Biblioteca utilizando un bucle for i in 0..<libros.count para mutar directamente libros[i].estado, aplicando switch para el reporte de inventario e incluyendo un comentario por cada línea.

### ¿Funcionó a la primera?
Sí, gracias a las restricciones explícitas del prompt CTRFE no utilizó closures ni opcionales innecesarios.

### ¿Usó algo que no hemos visto en clase?
No. Respetó la exclusión de firstIndex(where:), guard let y didSet.

## Mi versión (Parte A) vs. la versión de la IA (Parte B)
### ¿Qué hizo distinto la IA respecto a mi solución?
La lógica central fue prácticamente idéntica; la diferencia principal radicó en la rigurosidad de los comentarios explicativos en cada una de las líneas y en la estandarización del descarte del valor de retorno con _ =.

### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?
Ninguna, todas las líneas se mantuvieron dentro de la sintaxis trabajada en las semanas 1 a 4.

### ¿Qué me pareció mejor de MI versión?
Fue más rápida de escribir y concisa al omitir comentarios en líneas triviales como declaraciones simples o llaves de cierre.

### ¿Qué me pareció mejor de la versión de la IA?
La claridad pedagógica de documentar por qué se modifica el struct por índice libros[i].estado para evitar trabajar sobre copias.