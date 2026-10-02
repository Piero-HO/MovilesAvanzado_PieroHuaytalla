# Prompts utilizados — Laboratorio 06

## **Herramienta de IA utilizada en esta actividad:**
Codex (ChatGPT)

## Ejercicio 4: Calculadora de Venta a Plazos de Electrodoméstico



### Prompt consolidado (CTRFE)

**Contexto:** Soy estudiante de Programación en Móviles Avanzado. Trabajo en Xcode con Swift, UIKit y Storyboard en la rama `ai-assisted`. Ya practiqué pantallas con `UINavigationController`, segues, `IBOutlet`, modelos propios y paso de datos entre controladores.

**Tarea:** Ayúdame a completar una aplicación con dos pantallas: «Nueva Venta», que recibe el nombre del electrodoméstico, precio unitario, cantidad, número de meses y tasa de interés mensual; y «Resultado», que muestra subtotal, IGV, base, intereses totales, total a pagar y cuota mensual. Usa un `VentaModel` para reunir las seis salidas y pásalo con `prepare(for:sender:)` mediante un segue `Show` identificado como `showResultado`.

**Restricciones:** Usa solo conceptos vistos hasta la semana 6: clases, `NSObject`, `UIViewController`, `UINavigationController`, Storyboard, `IBOutlet`, segues y `prepare(for:sender:)`. No uses SwiftUI, Combine, Codable, persistencia ni bibliotecas externas. Sigue exactamente las fórmulas de la guía y presenta los montos en soles con dos decimales. Explica por qué el ejercicio usa `class` en `VentaModel`, sin afirmar que un `struct` impediría pasar datos entre pantallas.

**Formato:** Proporciona instrucciones paso a paso para Interface Builder, nombres concretos para las conexiones y código Swift separado por archivo. Incluye un caso de prueba numérico y señala los puntos que todavía requieran validación en Xcode.

**Ejemplo:** Para precio unitario S/ 3500, cantidad 1, plazo de 12 meses e interés mensual de 1 %, el resultado esperado es subtotal S/ 3500.00, IGV S/ 630.00, base S/ 4130.00, intereses S/ 495.60, total S/ 4625.60 y cuota mensual S/ 385.47.

### Fórmulas solicitadas

```text
subtotal  = precioUnitario × cantidad
igv       = subtotal × 0.18
base      = subtotal + igv
intereses = base × (tasaInteresMensual / 100) × meses
total     = base + intereses
cuota     = total / meses
```

### Respuesta de la IA y revisión del proyecto

La IA propuso los controles de ambas pantallas, el segue `showResultado`, una clase `VentaModel` con seis propiedades `Double`, el cálculo en `ViewController.prepare(for:sender:)` y el formateo de las seis etiquetas en `ResultadoViewController.viewDidLoad()`.

Al revisar los archivos locales, se observan esas dos pantallas, el segue, el modelo y los dos controladores. Probé el caso del ejemplo en el simulador y obtuve el resultado esperado. El código todavía convierte números no válidos en valores predeterminados (`0` para precio, cantidad e interés; `1` para meses), así que una entrada vacía podría mostrar un resultado en vez de un aviso. Además, el nombre del electrodoméstico se pide, pero no se muestra en la pantalla de resultado. Esos casos quedan pendientes de revisión.

### ¿Funcionó a la primera?

Sí. Al ingresar los datos del ejemplo en el simulador, la pantalla mostró los importes esperados. Todavía tendría que probar qué ocurre con campos vacíos o valores incorrectos.

### ¿La IA utilizó algo que no se había visto en clase?

Sí. No había usado antes la conversión de coma a punto ni `guard` para verificar el identificador del segue y el controlador de destino. Revisé esas partes para entender qué hacen antes de usarlas.

### Comparación con el ejercicio manual anterior

En el ejercicio manual de datos del cliente se presentó una segunda pantalla de forma modal con `present(...)`. En esta actividad, la IA organizó la navegación con un segue `Show` dentro de un `UINavigationController` y preparó el modelo antes de la transición. La ventaja práctica de `Show` en este flujo es que el usuario puede volver con el botón de navegación. En ambos casos se pasa un objeto propio; cambia el modo de presentación y el momento en que se configura el destino.

### ¿Por qué `class` y no `struct` para `VentaModel`?

Se eligió `class` para mantener el patrón de `ClienteModel` del ejercicio anterior y practicar un objeto de referencia que se entrega al siguiente controlador. Un `struct` también podría pasar las seis cifras mediante una propiedad del controlador de destino: al asignarlo se copiaría el valor. Por tanto, `class` es una elección didáctica de esta guía, no un requisito técnico para que `prepare(for:sender:)` funcione.

## Conclusiones

1. **¿Cuándo usaría `Show` y cuándo `Present Modally`?** En la calculadora usé `Show` porque el resultado es el siguiente paso de la venta y puedo volver con Atrás para cambiar un dato. Usaría `Present Modally` para algo más temporal, como una confirmación o un formulario que se cierra al terminar.
2. **¿Para qué sirven `Show Detail` y `Present As Popover`?** Entendí que `Show Detail` es útil cuando selecciono algo de una lista y quiero verlo en una zona de detalle, sobre todo en iPad. `Present As Popover` lo usaría para mostrar opciones pequeñas desde un botón, por ejemplo un filtro. En iPhone puede verse de otra manera por el tamaño de pantalla.
3. **¿Qué pasaría si `ClienteModel` o `VentaModel` fueran `struct`?** Los datos sí llegarían a la otra pantalla. La diferencia es que se enviaría una copia del modelo. Con una `class`, las dos pantallas pueden referirse al mismo objeto. Si quisiera modificarlo en la segunda pantalla y reflejar ese cambio al volver, con `struct` tendría que pasar el valor actualizado de regreso.
4. **¿Qué noté entre el ejercicio manual y el asistido por IA?** En el ejercicio manual tuve que ir entendiendo cada conexión y cómo abrir la segunda pantalla. Con la IA avancé más rápido en las fórmulas y en el paso de datos con `prepare(for:sender:)`. El ejemplo funcionó en el simulador, pero aprendí que también debo probar entradas vacías o incorrectas: que funcione con un caso no significa que ya esté todo revisado.
