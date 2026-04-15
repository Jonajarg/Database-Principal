CREATE DATABASE borrador_fn0_principal;
USE borrador_fn0_principal;


#--------------------------------------------#
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    tipo_rol VARCHAR(20) NOT NULL
);
CREATE TABLE personal (
    id_personal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    telefono VARCHAR(10) NOT NULL UNIQUE,
    fecha_registro DATE NULL
);
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    passw VARCHAR(30) NOT NULL UNIQUE,
    estado_usuario BOOLEAN DEFAULT TRUE,
    fecha_creacion DATE NOT NULL,
    email VARCHAR(80) NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
# --------------------------------------------- #


# ----------------------------------------------#
CREATE TABLE proveedores (
	id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    telefono VARCHAR(10) NOT NULL,
    email VARCHAR(20) NOT NULL,
    pagina_web VARCHAR(40) NULL
);
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo_producto VARCHAR(22) NOT NULL UNIQUE,
    nombre_producto VARCHAR(45) NOT NULL,
    precio_venta INT NOT NULL,
    costo_unitario INT NOT NULL,
    marca_producto VARCHAR(33) NULL,
    fecha_producto DATE NULL,
    disponible BOOLEAN DEFAULT TRUE
);
CREATE TABLE compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_compra DATE NOT NULL,
    total_compra INT NOT NULL,
    cantidad_producto INT NOT NULL,
    costo_unitario INT NOT NULL,
    subtotal INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
#-------------------------------------------------------- #


# -------------------------------------------------------- #
CREATE TABLE materiales (
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    nombre_material VARCHAR(80) NOT NULL,
    tipo_material VARCHAR(12) NOT NULL,
    descripcion_material VARCHAR(100) NULL,
    marca_material VARCHAR(30) NULL
);

CREATE TABLE transferencias (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    num_trayecto_transferencia INT NOT NULL UNIQUE,
    origen_transferencia VARCHAR(40) NOT NULL,
    destino_transferencia VARCHAR(40) NOT NULL,
    tipo_transferencia INT NOT NULL,
    fecha_transferencia DATE NOT NULL
);
CREATE TABLE detalle_producto_transferencias (
    id_detalle_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    id_transferencia INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_transferencia INT NOT NULL,
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
    monto_egreso INT NOT NULL,
    descripcion_egreso VARCHAR(65) NOT NULL,
    fecha_egreso DATE NOT NULL
);
CREATE TABLE partidos (
    id_partido INT AUTO_INCREMENT PRIMARY KEY,
    nombre_partido VARCHAR(40) NOT NULL,
    num_local_partido INT NOT NULL,
    tipo_partido VARCHAR(8) NOT NULL,
    equipo_local VARCHAR(30) NOT NULL,
    equipo_rival VARCHAR(30) NOT NULL,
    clima VARCHAR(27) NULL,
    hora_partido TIME NOT NULL,
    fecha_partido DATE NOT NULL,
    estado_partido BOOLEAN DEFAULT TRUE
);
CREATE TABLE locales (
    id_local INT AUTO_INCREMENT PRIMARY KEY,
    nombre_local VARCHAR(40) NOT NULL,
    ubicacion VARCHAR(45) NULL,
    local_activo BOOLEAN DEFAULT TRUE
);
CREATE TABLE incentivos_personal (
    id_incentivo INT AUTO_INCREMENT PRIMARY KEY,
    id_personal INT NOT NULL,
    id_partido INT NOT NULL,
    id_egreso INT NOT NULL,
    tipo VARCHAR(12) NOT NULL,
    motivo VARCHAR(100) NOT NULL,
    monto INT NOT NULL,
    fecha_incentivo DATE NULL,
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
    cantidad_productos_vendidos INT NOT NULL,
    total_vendido INT NOT NULL,
    total_comisiones INT NOT NULL,
    observaciones VARCHAR(95) NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);
CREATE TABLE detalle_reportes_personal (
    id_detalle_reportes_personal INT AUTO_INCREMENT PRIMARY KEY,
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
    inv_local INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    cantidad_disponible INT NOT NULL,
    fecha_actualizacion DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE inventario_material (
    id_inv_material INT AUTO_INCREMENT PRIMARY KEY,
    id_material INT NOT NULL,
    cantidad_total INT NOT NULL,
    cantidad_disponible INT NOT NULL,
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE movimientos_inventario (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    trayecto_movimiento INT NOT NULL,
    origen_movimiento VARCHAR(20) NOT NULL,
    destino_movimiento VARCHAR(20) NOT NULL,
    tipo_movimiento VARCHAR(15) NOT NULL,
    cantidad_movimiento INT NOT NULL,
    fecha_movimiento DATE NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE material_local (
    id_material_local INT AUTO_INCREMENT PRIMARY KEY,
    id_local INT NOT NULL,
    id_material INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locales(id_local)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
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
    total_efectivo_entragado INT NOT NULL,
    estado_hoja BOOLEAN DEFAULT TRUE,
    observacioes_hoja VARCHAR(100) NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_local) REFERENCES locales(id_local)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE detalle_hoja_producto (
    id_detalle_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_inicial INT NOT NULL,
    cantidad_recarga INT NOT NULL,
    cantidad_total INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    cantidad_devuelta INT NOT NULL,
    cantidad_merma INT NOT NULL,
    cantidad_final INT NOT NULL,
    precio_unitario INT NOT NULL,
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
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    cantidad_restante INT NOT NULL,
    CONSTRAINT fk_inventario_vendedor_hoja_trabajo FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE material_vendedor (
    id_material_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_material_local INT NOT NULL,
    id_material INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    estado_material_vendedor BOOLEAN DEFAULT TRUE,
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
    id_hoja INT NULL,
    cantidad_merma INT NOT NULL,
    motivo_merma VARCHAR(65) NOT NULL,
    fecha_merma DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ingresos (
    id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    total_ingresos INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ganancias (
    id_ganancia INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    total_egresos INT NOT NULL,
    ganancia_neta INT NOT NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE convocatoria_partido (
    id_convocatoria INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    id_personal INT NOT NULL,
    tipo_convocatoria VARCHAR(20) NOT NULL,
    fecha_convocatoria DATE NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_convocatoria_partido FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);
CREATE TABLE asignacion_final (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    id_personal INT NOT NULL,
    id_rol INT NOT NULL,
    rol_final VARCHAR(20) NOT NULL,
    reemplaza_a VARCHAR(30) NULL,
    cantidad_personal INT NOT NULL,
    CONSTRAINT fk_asignacion_final_partido FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
    ON DELETE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE devoluciones (
    id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_devoluciones INT NOT NULL,
    motivo_devolucion VARCHAR(57) NOT NULL,
    fecha_devolucion DATE NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE mermas_vendedor (
    id_merma_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_mermas_vendedor INT NOT NULL,
    motivo_merma_vendedor VARCHAR(58) NOT NULL,
    fecha_merma_vendedor DATE NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE movimientos_caja (
    id_movimiento_caja INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_transferencia INT NULL,
    tipo_movimiento_caja VARCHAR(15) NOT NULL,
    monto INT NOT NULL,
    fecha_movimiento DATE NOT NULL,
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
    cantidad_recarga INT NOT NULL,
    fecha_recarga DATE NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja)
    ON DELETE CASCADE ON UPDATE CASCADE
);
# ------------------------------------------- #