# Registro utilizados - Laboratorio 02

## Herramienta de IA utilizada
Gemini

---

## Ejercicio 6: Carrito Mejorado con IA

### Prompt (estructura CTRFE):
```
- **CONTEXTO:** Soy estudiante de Diseño y Desarrollo de Software en Tecsup cursando Programación Móvil Avanzada y trabajando en Swift Playgrounds en la rama `ai-assisted`.
- **TAREA:** Genera el código para mejorar un carrito de compras agregando: 1) Descuento por cantidad del 5% si un producto tiene 3 o más unidades. 2) Cupón "DESCUENTO20" que aplica 20% adicional. 3) Envío gratis si el total > 3000, sino cuesta S/. 25.00. 4) Puntos de fidelidad (1 punto por cada S/. 100). 5) Validación de precios negativos o cantidades 0 emitiendo error.
- **RESTRICCIONES:** Solo Swift básico para Playground, no usar colecciones ni arreglos (solo variables/constantes individuales y condicionales), sin funciones complejas.
- **FORMATO:** Código Swift completamente funcional, con un comentario descriptivo en CADA línea de código y salida de ticket alineada en consola con 2 decimales.
- **EJEMPLO:**
"swift" let factorDesc = cantidad >= 3 ? 0.95 : 1.0 // Aplica 5% si compra 3 o más unidades
```

### ¿Funcionó a la primera?
Sí, generó la lógica completa implementando las 5 condiciones requeridas.

### ¿La IA usó algo que no conocias?
No, utilizo estructuras entendibles y nada de estrucutras avanzadas.

---

## Ejercicio 7 Juego de adivinanza

### Prompt (estructura CTRFE):
```
- **CONTEXTO:** Soy estudiante de Diseño y Desarrollo de Software en Tecsup cursando Programación Móvil Avanzada y trabajando en Swift Playgrounds dentro de la rama `ai-assisted`.
- **TAREA:** Desarrolla un minijuego de adivinanza de números en Swift que cumpla lo siguiente:
  1. Un número secreto fijo (ejemplo: 42).
  2. Simular 5 intentos con variables independientes (`intentoN1 = 20`, `intentoN2 = 50`, etc.)[cite: 1].
  3. Usar un bucle `while` para recorrer y evaluar los intentos[cite: 1].
  4. En cada intento, mostrar si el número es "Muy alto", "Muy bajo" o "¡Correcto!"[cite: 1].
  5. Contar cuántos intentos necesitó para adivinar[cite: 1].
  6. Si no adivinó en 5 intentos, mostrar "Perdiste. El número era: X"[cite: 1].
- **RESTRICCIONES:** Solo Swift básico en Playground, no usar colecciones ni arreglos (`Array`); únicamente variables simples, bucle `while` y estructuras `if/else`[cite: 1].
- **FORMATO:** Código Swift completamente ejecutable con un comentario explicativo en CADA línea de código explicando la lógica de comparación y salida limpia en consola[cite: 1].
- **EJEMPLO:**
"swift" while turnoActual <= 5 && !haAdivinado { // Ejecuta el bucle mientras queden intentos y no se haya ganado
```
### ¿Funcionó a la primera?
Sí, generó la estructura del bucle "while" evaluando las condiciones numéricas y deteniendo la ejecución al agotar sus intentos.

### ¿La IA usó algo que no conocias?
No, uso variables constantes, variables y operadores de comparación.