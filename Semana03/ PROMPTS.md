# Prompts Lab 03 - Colecciones

## Datos Generales
- **Curso:** Programación en Móviles Avanzado
- **Docente:** Juan Leon
- **Estudiante:** Piero Huaytalla
- **Herramienta IA:** Gemini

---

## Ejercicio 6: Gestión de Notas

### Prompt (CTRFE):
- **CONTEXTO:** Soy estudiante del curso Programación en Móviles Avanzado en Tecsup. Estamos trabajando con Swift en Playground usando arrays, diccionarios y operaciones básicas.
- **TAREA:** Desarrollar un sistema de registro y procesamiento de notas interactivo que:
  1. Solicite N alumnos con su nombre y exactamente 3 notas numéricas, almacenándolos en un diccionario `[String: [Double]]`.
  2. Calcule el promedio de cada alumno y clasifique el resultado mediante una estructura `switch` (Excelente para 18-20, Bueno para 15-<18, Aprobado para 13-<15, Desaprobado para <13).
  3. Muestre estadísticas globales: promedio general de la clase, nota individual más alta, nota individual más baja y porcentaje de alumnos aprobados.
  4. Muestre la lista final de alumnos ordenada de mayor a menor según su promedio.
- **RESTRICCIONES:** 
  - Usar únicamente sintaxis y conceptos (variables, bucles `for`/`while`, condicionales `if`/`switch`, colecciones `Array`/`Dictionary` y lectura por consola con `readLine()`).
  - PROHIBIDO el uso de `struct`, `class`, closures complejas no vistas o librerías externas avanzadas.
  - Incluir cabecera obligatoria: `// Desarrollado por: Piero Huaytalla`.
- **FORMATO:** Código Swift completamente funcional, con comentarios explicativos en cada una de las líneas de código.
- **EJEMPLO:**
  Entrada:
  ¿Cuántos alumnos? 1
  Nombre: Carlos
  Nota 1: 18, Nota 2: 16, Nota 3: 17
  Salida esperada:
  Alumno: Carlos | Promedio: 17.00 | Estado: Bueno
  Promedio general: 17.00 | % Aprobados: 100.0%

---

## Ejercicio 7: Inventario con Menú

### Prompt (CTRFE):
- **CONTEXTO:** Estudiante de desarrollo móvil en Swift trabajando con colecciones, estructuras repetitivas y control de flujo en consola.
- **TAREA:** Implementar un sistema de inventario interactivo que:
  1. Solicite registrar inicialmente N productos con su nombre, precio unitario (`Double`) y stock disponible (`Int`), almacenándolos en dos diccionarios paralelos (`[String: Double]` y `[String: Int]`).
  2. Implemente un menú repetitivo con `while` que ofrezca las siguientes opciones:
     1) Ver inventario completo con subtotales por producto.
     2) Buscar un producto por nombre y ver sus existencias y precio.
     3) Mostrar productos con stock bajo (< 5 unidades).
     4) Calcular y mostrar el valor financiero total del almacén.
     5) Salir del programa.
- **RESTRICCIONES:**
  - No usar POO (`struct`, `class` ni protocolos).
  - Manejo seguro de entradas numéricas y opcionales (`??` e `if let`).
  - Cabecera: `// Desarrollado por: Piero Huaytalla`.
- **FORMATO:** Código Swift listo para ejecutar en consola/Playground, con comentarios explicativos obligatorios línea por línea.
- **EJEMPLO:**
  Opciones desplegadas en menú numerado (1 a 5). Opción 3 debe advertir ítems con stock < 5 unidades.