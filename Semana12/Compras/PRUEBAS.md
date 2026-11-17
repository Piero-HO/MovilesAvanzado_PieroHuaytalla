# Casos para verificar — Compras (Grupo B)

La guía pide demostrar los casos siguientes en el simulador. Marcar el resultado real al probarlos; no se han dado por aprobados solo por compilar.

1. Registrar `mtorres` como Comprador. Cerrar sesión e intentar registrar `MTORRES`: se rechaza el usuario repetido.
2. Intentar acceder con clave incorrecta: aparece «Usuario o clave incorrectos».
3. Un supervisor crea producto con stock 40 y costo promedio 110. Un comprador registra 10 a 120 al crédito: subtotal 1200, IGV 216, total 1416, aprobado, stock 50, promedio 112 y vencimiento a 30 días.
4. Registrar una compra equivalente al contado: pagada, no aparece pendiente de pago.
5. Partiendo de stock 40 y promedio 110, registrar 50 a 120 al crédito: total 7080, pendiente, stock sin cambios ni cuenta por pagar.
6. Supervisor aprueba el caso 5: stock 90, costo promedio 115.56 y cuenta por pagar.
7. Rechazar una compra pendiente: no se permite sin motivo; con motivo se muestra al comprador y no cambia el inventario.
8. Una cuenta vencida aparece en Vencidas; al deslizar Pagar pasa a Pagadas y baja el total por pagar.
9. Un comprador solo ve sus compras y no puede pagar.

También comprobar persistencia tras reiniciar, permisos de catálogos, imposibilidad de borrar entidades con compras y búsqueda por proveedor.
