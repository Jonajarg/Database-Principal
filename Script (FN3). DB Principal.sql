CREATE DATABASE borrador_fn3_principal;
USE borrador_fn3_principal;


#--------------------------------------------#
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    tipo_rol VARCHAR(20) NOT NULL
);
CREATE TABLE personal (
    id_personal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NULL,
    telefono VARCHAR(10) NOT NULL UNIQUE,
    fecha_registro DATE NULL
);
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    id_personal INT NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    passw VARCHAR(30) NOT NULL UNIQUE,
    estado_usuario BOOLEAN DEFAULT TRUE,
    fecha_creacion DATE NOT NULL,
    email VARCHAR(80) NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE usuario_personal (
	id_usuario_personal INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_personal INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
	ON DELETE CASCADE ON UPDATE CASCADE
);
# --------------------------------------------- #


# ----------------------------------------------#
CREATE TABLE proveedores (
	id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NULL,
    telefono VARCHAR(10) NOT NULL,
    email VARCHAR(45) NOT NULL,
    pagina_web VARCHAR(90) NULL
);
CREATE TABLE codigo_producto (
    id_codigo_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo_producto VARCHAR(22) NOT NULL UNIQUE,
    costo_unitario INT NOT NULL,
    marca VARCHAR(33) NOT NULL
);
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_codigo_producto INT NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    precio_venta INT NOT NULL,
    fecha_producto DATE NULL,
    disponible BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_producto_codigo_producto FOREIGN KEY (id_codigo_producto) REFERENCES codigo_producto(id_codigo_producto)
    ON DELETE CASCADE
);
CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha DATE NOT NULL,
    total INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE detalle_compra (
    id_detalle_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    costo_unitario INT NOT NULL,
    subtotal INT NOT NULL,
    CONSTRAINT fk_detalle_compra_compras FOREIGN KEY (id_compra) REFERENCES compras(id_compra)
    ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
#-------------------------------------------------------- #


# -------------------------------------------------------- #
CREATE TABLE materiales (
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    tipo_material VARCHAR(20) NOT NULL,
    descripcion VARCHAR(100) NULL,
    marca VARCHAR(30) NULL
);

CREATE TABLE transferencias (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    tipo_transferencia INT NOT NULL,
    fecha DATE NOT NULL
);
CREATE TABLE trayecto_transferencia (
    id_trayecto_trans INT NOT NULL UNIQUE PRIMARY KEY,
    id_transferencia INT NOT NULL,
    origen_trans VARCHAR(40) NOT NULL,
    destino_trans VARCHAR(40) NOT NULL,
    CONSTRAINT fk_trayecto_transferencia_transferencias FOREIGN KEY (id_transferencia) REFERENCES transferencias(id_transferencia)
    ON DELETE CASCADE
);
CREATE TABLE detalle_producto_transferencia (
    id_detalle_trans INT AUTO_INCREMENT PRIMARY KEY,
    id_transferencia INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_transferencia) REFERENCES transferencias(id_transferencia)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);

# -------------------------------------------------------- #


# --------------------------------------------------------- #
CREATE TABLE egresos (
    id_egreso INT AUTO_INCREMENT PRIMARY KEY,
    tipo_egreso VARCHAR(20) NOT NULL,
    monto INT NOT NULL,
    descripcion VARCHAR(65) NOT NULL,
    fecha DATE NOT NULL
);
CREATE TABLE partidos (
    id_partido INT AUTO_INCREMENT PRIMARY KEY,
    nombre_partido VARCHAR(40) NOT NULL,
    tipo_partido VARCHAR(20) NOT NULL,
    hora_partido TIME NOT NULL,
    fecha_partido DATE NOT NULL,
    estado_partido BOOLEAN DEFAULT TRUE
);
CREATE TABLE detalle_partido (
    id_detalle_partido INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    equipo_local VARCHAR(30) NOT NULL,
    equipo_visitante VARCHAR(30) NOT NULL,
    clima VARCHAR(27) NULL,
    CONSTRAINT fk_detalle_partido_partidos FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE
);
CREATE TABLE locales (
    id_local INT AUTO_INCREMENT PRIMARY KEY,
    nombre_local VARCHAR(40) NOT NULL,
    ubicacion VARCHAR(45) NOT NULL,
    local_activo BOOLEAN DEFAULT TRUE
);
CREATE TABLE partido_local (
	id_partido_local INT AUTO_INCREMENT PRIMARY KEY,
    id_local INT NOT NULL,
    id_partido INT NOT NULL,
    num_local_partido INT NOT NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE,
	FOREIGN KEY (id_local) REFERENCES locales(id_local)
    ON DELETE CASCADE
);
CREATE TABLE incentivos_personal (
    id_incentivo INT AUTO_INCREMENT PRIMARY KEY,
    id_personal INT NOT NULL,
    id_partido INT NOT NULL,
    id_egreso INT NOT NULL,
    tipo_incentivo VARCHAR(20) NOT NULL,
    motivo VARCHAR(100) NOT NULL,
    monto INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_egreso) REFERENCES egresos(id_egreso)
    ON DELETE CASCADE ON UPDATE CASCADE
);
# ---------------------------------------------------------- #


# ----------------------------------------------------------- #
CREATE TABLE reportes_personal (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    fecha_generacion DATE NOT NULL,
    cantidad_productos INT NOT NULL,
    total_vendido INT NOT NULL,
    total_comisiones INT NOT NULL,
    observaciones VARCHAR(95) NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);
CREATE TABLE detalle_reportes_personal (
    id_detal_rep_per INT AUTO_INCREMENT PRIMARY KEY,
    id_reporte INT NOT NULL,
    id_personal INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    subtotal INT NOT NULL,
    FOREIGN KEY (id_reporte) REFERENCES reportes_personal(id_reporte)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE
);
# ------------------------------------------------------------ #


# ------------------------------------------------------------ #
CREATE TABLE asistencias (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_personal INT NOT NULL,
    id_partido INT NOT NULL,
    asistio BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE ON UPDATE CASCADE
);
# ------------------------------------------------------------ #


# ------------------------------------------------------------ #
CREATE TABLE inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    fecha_actualizacion DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE inventario_material (
    id_inv_material INT AUTO_INCREMENT PRIMARY KEY,
    id_material INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE inventario_local (
    id_inv_local INT AUTO_INCREMENT PRIMARY KEY,
    id_inventario INT NOT NULL,
    id_local INT NOT NULL,
    id_producto INT NOT NULL,
    id_material INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    cantidad_disponible INT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locales(id_local)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE movimientos_inventario (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    tipo_movimiento VARCHAR(20) NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE trayecto_movimientos_inventario (
    id_trayecto_mov INT AUTO_INCREMENT PRIMARY KEY,
    id_movimiento INT NOT NULL,
    origen_movimiento VARCHAR(40) NOT NULL,
    destino_movimiento VARCHAR(40) NOT NULL,
    CONSTRAINT fk_trayecto_movimientos_inventario FOREIGN KEY (id_movimiento) REFERENCES movimientos_inventario(id_movimiento)
    ON DELETE CASCADE
);
CREATE TABLE material_local (
    id_material_local INT AUTO_INCREMENT PRIMARY KEY,
    id_local INT NOT NULL,
    id_material INT NOT NULL,
    id_inv_local INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locales(id_local)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_inv_local) REFERENCES inventario_local(id_inv_local)
	ON DELETE CASCADE ON UPDATE CASCADE
);
# ------------------------------------------------------------ #


# ------------------------------------------------------------ #
CREATE TABLE hoja_trabajo (
    id_hoja INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    id_personal INT NOT NULL,
    id_local INT NOT NULL,
    fecha_hoja DATE NOT NULL,
    fondo_inicial INT NOT NULL,
    total_vendido INT NOT NULL,
    total_abonos INT NOT NULL,
    total_devoluciones INT NOT NULL,
    total_recargas INT NOT NULL,
    total_comisiones INT NOT NULL,
    total_efec_entragado INT NOT NULL,
    estado_hoja BOOLEAN DEFAULT TRUE,
    observaciones VARCHAR(100) NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_local) REFERENCES locales(id_local)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE detalle_hoja_producto (
    id_detalle_produ INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_inicial INT NOT NULL,
    cantidad_recarga INT NOT NULL,
    cantidad_total INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    cantidad_devuelta INT NOT NULL,
    cantidad_mermas INT NOT NULL,
    cantidad_final INT NOT NULL,
    subtotal INT NOT NULL,
    CONSTRAINT fk_detalle_hoja_producto_hoja_trabajo FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
# ------------------------------------------------------------------- #


# ------------------------------------------------------------------- #
CREATE TABLE inventario_vendedor (
    id_inv_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    id_inv_local INT NOT NULL,
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    cantidad_restante INT NOT NULL,
    CONSTRAINT fk_inventario_vendedor_hoja_trabajo FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_inv_local) REFERENCES inventario_local(id_inv_local)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE material_vendedor (
    id_material_ven INT AUTO_INCREMENT PRIMARY KEY,
    id_material INT NOT NULL,
    id_material_local INT NOT NULL,
    id_hoja INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    estado_material BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_material_local) REFERENCES material_local(id_material_local)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE
);
# --------------------------------------------------------------------- #


# ---------------------------------------------------------------------- #
CREATE TABLE mermas (
    id_merma INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_hoja INT NOT NULL,
    cantidad INT NOT NULL,
    motivo VARCHAR(65) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ingresos (
    id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    total INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ganancias (
    id_ganancia INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    total INT NOT NULL,
    ganancia_neta INT NOT NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE convocatoria_partido (
    id_convocatoria INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT fk_convocatoria_partido FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);
CREATE TABLE detalle_convocatoria (
    id_detalle_conv INT AUTO_INCREMENT PRIMARY KEY,
    id_convocatoria INT NOT NULL,
    id_personal INT NOT NULL,
    tipo_convocatoria VARCHAR(25) NOT NULL,
    CONSTRAINT fk_detalle_convocatoria_convocatoria FOREIGN KEY (id_convocatoria) REFERENCES convocatoria_partido(id_convocatoria)
    ON DELETE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE asignacion_final (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    id_personal INT NOT NULL,
    CONSTRAINT fk_asignacion_final_partido FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE detalle_asignacion_final (
    id_detalle_asig INT AUTO_INCREMENT PRIMARY KEY,
    id_asignacion INT NOT NULL,
    id_rol INT NOT NULL,
    rol_final VARCHAR(20) NOT NULL,
    reemplaza_a VARCHAR(30) NULL,
    cantidad_personal INT NOT NULL,
    CONSTRAINT fk_detalle_asignacion_final_asignacion_final FOREIGN KEY (id_asignacion) REFERENCES asignacion_final(id_asignacion)
    ON DELETE CASCADE,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE devoluciones (
    id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    motivo VARCHAR(57) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE mermas_vendedor (
    id_merma_vend INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_mermas INT NOT NULL,
    motivo VARCHAR(58) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE movimientos_caja (
    id_movimiento_caja INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_transferencia INT NOT NULL,
    tipo_movimiento VARCHAR(22) NOT NULL,
    monto INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_movimiento_caja_transferencia FOREIGN KEY (id_transferencia) REFERENCES transferencias(id_transferencia)
    ON DELETE CASCADE
);
CREATE TABLE comisiones (
    id_comision INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    porcentaje DECIMAL NOT NULL,
    monto_calculado DECIMAL NOT NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE recargas (
	id_recarga INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE
);
# ------------------------------------------- #