# Requerimientos funcionales — Actividad propuesta 01

## 1. Descripción

El sistema debe generar la factura de un alumno inscrito en uno o más cursos libres de Tecsup. La factura debe calcular el IGV, aplicar los descuentos correspondientes y mostrar el importe final que debe pagar el alumno.

## 2. Actor

- **Responsable de inscripción:** registra al alumno y los cursos adquiridos, y solicita la generación de la factura.

## 3. Requerimientos funcionales

### RF-01: Registrar los datos del alumno

El sistema debe permitir registrar:

- Nombre completo.
- DNI.
- Condición de alumno de Tecsup.

### RF-02: Registrar los cursos

El sistema debe permitir registrar uno o más cursos. Cada curso debe contener:

- Nombre del curso.
- Precio unitario.
- Cantidad adquirida.

### RF-03: Calcular el importe por curso

El sistema debe calcular el importe de cada curso multiplicando su precio unitario por la cantidad adquirida.

```text
Importe del curso = precio unitario × cantidad
```

### RF-04: Calcular la cantidad total de cursos

El sistema debe sumar las cantidades de todos los cursos inscritos para determinar si el alumno cumple la cantidad mínima requerida para recibir descuentos.

### RF-05: Calcular el subtotal

El sistema debe calcular el subtotal sumando los importes de todos los cursos.

### RF-06: Calcular el IGV

El sistema debe calcular un IGV equivalente al 18 % del subtotal.

```text
IGV = subtotal × 18 %
```

### RF-07: Calcular el total con IGV

El sistema debe sumar el subtotal y el IGV para obtener el total con IGV.

### RF-08: Aplicar el descuento por cantidad

Si el alumno adquiere tres o más cursos, el sistema debe aplicar un descuento equivalente al 10 % del total con IGV.

### RF-09: Aplicar el descuento especial Tecsup

Si el alumno pertenece a Tecsup y adquiere tres o más cursos, el sistema debe aplicar un descuento adicional de S/ 400.00.

### RF-10: Calcular el total final

El sistema debe restar del total con IGV el descuento por cantidad y el descuento especial Tecsup. El resultado final no debe ser menor que cero.

```text
Total final = total con IGV − descuento por cantidad − descuento Tecsup
```

### RF-11: Mostrar la factura

El sistema debe mostrar:

- Datos del alumno.
- Condición de alumno de Tecsup.
- Nombre, cantidad e importe de cada curso.
- Subtotal.
- IGV.
- Total con IGV.
- Descuentos aplicados o la indicación de que no corresponden.
- Total final que debe pagar el alumno.

## 4. Reglas de negocio

- **RN-01:** El IGV es el 18 % del subtotal.
- **RN-02:** Las cantidades de todas las líneas se suman para determinar el número de cursos adquiridos.
- **RN-03:** El descuento del 10 % solo se aplica cuando se adquieren tres o más cursos.
- **RN-04:** El descuento de S/ 400.00 solo se aplica cuando el comprador es alumno de Tecsup y adquiere tres o más cursos.
- **RN-05:** Ambos descuentos son acumulables cuando se cumplen sus condiciones.
- **RN-06:** El total final no puede ser negativo.

## 5. Criterio de aceptación principal

Dado un alumno de Tecsup que adquiere cuatro cursos, con un subtotal de S/ 2250.00, el sistema debe calcular:

- IGV: S/ 405.00.
- Total con IGV: S/ 2655.00.
- Descuento por cantidad: S/ 265.50.
- Descuento especial Tecsup: S/ 400.00.
- Total final: S/ 1989.50.
