# Cambios en el script de la base de datos.

Estos son todas las modificaciones realizadas en el script que contiene la base de datos en VRCN 1

## Cambios generales

- Se aumentó la longitud en VARCHAR de distintas tablas y se cambio el tipo de dato DATE por DATETIME en algunas tablas.
- Se han eliminado las condiciones de la llave foránea para agilizar los primeros pasos de la base de datos. Volverán a incluirse en el futuro.
- El modulo de finanzas se verá por el momento descartado




## Cambios por tabla

### roles
tipo_rol ha cambiado a nombre_rol


### personal
apellido_paterno ha cambiado a ape_paterno  
apellido_materno ha cambiado a ape_materno


### proveedores
apellido_paterno se ha descartado  
apellido_materno se ha descartado  
pagina_web se ha descartado


### codigo_producto
id_codigo_producto pasa a ser id_cd_prod  
codigo_producto pasa a ser cd_producto


### productos
id_codigo_producto pasa a ser id_cd_prod  
disponible se ha descartado


### materiales
id_cd_mate se ha agregado  
tipo_material se ha descartado  
descripción se ha descartado  
marca se ha descartado


### partidos
nombre_partido pasa a ser nombre  
tipo_partiddo se ha descartado  
hora_fecha fue agregado  
hora se ha descartado  
fecha se ha descartado


### detalle_partido
id_detalle_partido pasa a ser id_det_partido  
equipo_local se ha descartado


### locales
nombre_local se ha descartado  


### inventario_material
id_inv_material pasa a ser id_inve_mate  
ubicación fue agregado


### hoja_trabajo
observaciones ha sido descartado  
total_recargas ha sido descartado  
total_abonos ha sido descartado  
id_venta fue agregado  
id_comision fue agregado  
id_devolucion fue agregado


### detalle_hoja_producto
id_detalle_produ pasa a ser id_det_hoja_produ  
id_venta se ha agregado  
id_comision se ha agregado  
id_devolucion se ha agregado  
id_merma_vend se ha agregado


### material_vendedor
id_material_ven pasa a ser id_mate_ven  
id_material_local se ha descartado  
id_hoja se ha descartado  
id_local_mate fue agregado


### mermas
id_hoja se ha descartado


### asignacion_final
rol_final se ha agregado  
reemplaza_a se ha agregado


### devoluciones
id_hoja se ha descartado  
id_producto se ha descartado  
cantidad se ha descartado  
id_venta fue agregado


### mermas_vendedor
id_hoja se ha descartado


### comisiones
id_hoja se ha descartado  
id_venta fue agregado





## Tablas eliminadas

- usuario_personal
- compras
- detalle_compra
- transferencias
- trayecto_transferencia
- detalle_producto_transferencia
- egresos
- partido_local
- incentivos_personal
- reportes_personal
- detalle_reportes_personal
- inventario
- inventario_local
- movimientos_inventario
- trayecto_movimientos_inventario
- aterial_local
- inventario_vendedor
- ingresos
- ganancias
- convocatoria_partido
- detalle_convocatoria
- detalle_asignacion_final
- movimientos_caja
- recargas




## Tablas agregadas

- detalle_rol
- codigo_material
- proveedor_producto
- inventario_productos
- inventario_local_productos
- movimiento_producto
- compras_producto
- detalle_compra_producto
- proveedor_material
- inventario_local_material
- movimiento_material
- compras_material
- detalle_compra_material
- incentivos
- producto_vendedor
- ventas
- detalle_venta
- comisiones
- devoluciones
- pagos
reportes
detalle_reporte
