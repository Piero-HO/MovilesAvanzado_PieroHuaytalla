# Requerimientos funcionales — Actividad propuesta 02

## 1. Descripción

El sistema debe gestionar y mostrar información de clientes bancarios. Todos los clientes comparten información general, pero los clientes naturales y jurídicos poseen datos específicos. La solución debe utilizar herencia, sobrescritura de métodos y polimorfismo.

## 2. Actor

- **Responsable de atención:** registra los datos de los clientes y consulta su información.

## 3. Requerimientos funcionales

### RF-01: Registrar los datos generales de un cliente

El sistema debe permitir registrar para todo cliente:

- Código.
- Dirección.
- Fecha de registro.
- Número de cuenta.
- Monto mínimo de apertura.

### RF-02: Registrar un cliente natural

El sistema debe permitir registrar un cliente natural con los datos generales del cliente y los siguientes datos específicos:

- Nombre completo.
- DNI.

### RF-03: Registrar un cliente jurídico

El sistema debe permitir registrar un cliente jurídico con los datos generales del cliente y los siguientes datos específicos:

- Razón social.
- RUC.
- Representante legal.

### RF-04: Mostrar los datos generales

El sistema debe proporcionar una operación común para mostrar el código, la dirección, la fecha de registro, el número de cuenta y el monto mínimo de apertura de cualquier cliente.

### RF-05: Mostrar los datos de un cliente natural

Al consultar un cliente natural, el sistema debe mostrar su nombre completo y DNI, además de todos los datos generales heredados del cliente.

### RF-06: Mostrar los datos de un cliente jurídico

Al consultar un cliente jurídico, el sistema debe mostrar su razón social, RUC y representante legal, además de todos los datos generales heredados del cliente.

### RF-07: Sobrescribir la presentación de datos

Cada tipo de cliente debe sobrescribir la operación de presentación para incorporar sus datos específicos y reutilizar la presentación de los datos generales.

### RF-08: Gestionar clientes mediante polimorfismo

El sistema debe permitir almacenar clientes naturales y jurídicos en una colección común de tipo `Cliente` y ejecutar la presentación correspondiente según el tipo real de cada objeto.

### RF-09: Presentar importes monetarios

El sistema debe mostrar el monto mínimo de apertura en soles y con dos posiciones decimales.

## 4. Reglas de negocio

- **RN-01:** Todo cliente debe poseer los datos generales definidos por la clase base `Cliente`.
- **RN-02:** Un cliente natural debe identificarse mediante su nombre completo y DNI.
- **RN-03:** Un cliente jurídico debe identificarse mediante su razón social, RUC y representante legal.
- **RN-04:** Los datos específicos dependen del tipo de cliente y no reemplazan los datos generales.
- **RN-05:** La operación `mostrarDatos()` debe comportarse de acuerdo con el tipo real del cliente.

## 5. Criterios de aceptación

### CA-01: Cliente natural

Dado un cliente natural llamado Juan Pérez, el sistema debe mostrar su nombre, DNI, código, dirección, fecha de registro, número de cuenta y monto mínimo de apertura.

### CA-02: Cliente jurídico

Dado un cliente jurídico denominado Soluciones SAC, el sistema debe mostrar su razón social, RUC, representante legal, código, dirección, fecha de registro, número de cuenta y monto mínimo de apertura.

### CA-03: Polimorfismo

Dada una colección de tipo `Cliente` que contiene clientes naturales y jurídicos, el sistema debe ejecutar automáticamente la versión sobrescrita de `mostrarDatos()` correspondiente a cada objeto.
