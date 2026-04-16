CREATE DATABASE vrcn1_dbprincipal;
USE vrcn1_dbprincipal;

/*______________________________________________________________________*/

CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(40) NOT NULL
);
CREATE TABLE detalle_rol (
	id_det_rol INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    permiso_rol VARCHAR(40) NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);
CREATE TABLE personal (
    id_personal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ape_paterno VARCHAR(30) NOT NULL,
    ape_materno VARCHAR(30) NULL,
    telefono VARCHAR(10) NOT NULL UNIQUE,
    fecha_registro DATE NULL
);
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    id_personal INT NOT NULL,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    passw VARCHAR(45) NOT NULL UNIQUE,
    estado_usuario BOOLEAN DEFAULT TRUE,
    fecha_creacion DATE NOT NULL,
    email VARCHAR(105) NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);

/*______________________________________________________________________*/

CREATE TABLE proveedores (
	id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
    email VARCHAR(10)
);
CREATE TABLE codigo_producto (
	id_cd_prod INT AUTO_INCREMENT PRIMARY KEY,
    cd_producto VARCHAR(30) NOT NULL,
    costo_unitario INT NOT NULL,
    marca VARCHAR(50) NULL
);
CREATE TABLE codigo_material (
	id_cd_mate INT AUTO_INCREMENT PRIMARY KEY,
    cd_material VARCHAR(30) NOT NULL,
    costo_unitario INT NOT NULL,
    marca VARCHAR(50) NULL
);
CREATE TABLE locales (
    id_local INT AUTO_INCREMENT PRIMARY KEY,
    ubicacion VARCHAR(100) NOT NULL,
    local_activo BOOLEAN DEFAULT TRUE
);

/*______________________________________________________________________*/

CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_cd_prod INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    precio_venta INT NOT NULL,
    fecha_registro DATETIME NOT NULL,
    FOREIGN KEY (id_cd_prod) REFERENCES codigo_producto(id_cd_prod)
);
CREATE TABLE proveedor_producto (
	id_prov_prod INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
CREATE TABLE inventario_productos (
    id_inve_prod INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
CREATE TABLE inventario_local_productos (
    id_local_prod INT AUTO_INCREMENT PRIMARY KEY,
    id_inve_prod INT NOT NULL,
    id_local INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locales(id_local),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_inve_prod) REFERENCES inventario_productos(id_inve_prod)
);
CREATE TABLE movimiento_producto (
	id_movimiento_prod INT AUTO_INCREMENT PRIMARY KEY,
    id_personal INT NOT NULL,
    id_producto INT NOT NULL,
    nueva_ubicacion VARCHAR(105) NOT NULL,
    cantidad INT NOT NULL,
    fecha_hora DATETIME,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
CREATE TABLE compras_producto (
    id_compra_prod INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha_compra DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);
CREATE TABLE detalle_compra_producto (
	id_det_compra_prod INT AUTO_INCREMENT PRIMARY KEY,
    id_compra_prod INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
	monto INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_compra_prod) REFERENCES compras_producto(id_compra_prod)
);

/*______________________________________________________________________*/

CREATE TABLE materiales (
	id_material INT AUTO_INCREMENT PRIMARY KEY,
    id_cd_mate INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    fecha_registro DATE NOT NULL,
    FOREIGN KEY (id_cd_mate) REFERENCES codigo_material(id_cd_mate)
);
CREATE TABLE proveedor_material (
	id_prov_mate INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_material INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
);
CREATE TABLE inventario_material (
    id_inve_mate INT AUTO_INCREMENT PRIMARY KEY,
    id_material INT NOT NULL,
    catidad INT NOT NULL,
    ubicacion VARCHAR(105) NOT NULL,
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
);
CREATE TABLE inventario_local_material (
    id_local_mate INT AUTO_INCREMENT PRIMARY KEY,
    id_inve_mate INT NOT NULL,
    id_local INT NOT NULL,
    id_material INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locales(id_local),
    FOREIGN KEY (id_material) REFERENCES materiales(id_material),
    FOREIGN KEY (id_inve_mate) REFERENCES inventario_material(id_inve_mate)
);
CREATE TABLE movimiento_material (
	id_movimiento_mate INT AUTO_INCREMENT PRIMARY KEY,
    id_personal INT NOT NULL,
    id_material INT NOT NULL,
    nueva_ubicacion VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL,
    fecha_hora DATETIME,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
);
CREATE TABLE compras_material (
    id_compra_mate INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);
CREATE TABLE detalle_compra_material (
	id_det_compra_mate INT AUTO_INCREMENT PRIMARY KEY,
    id_compra_mate INT NOT NULL,
    id_material INT NOT NULL,
    cantidad INT NOT NULL,
	monto INT NOT NULL,
    FOREIGN KEY (id_compra_mate) REFERENCES compras_material(id_compra_mate),
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
);

/*______________________________________________________________________*/

CREATE TABLE partidos (
    id_partido INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(70) NOT NULL,
    fecha_hora DATETIME NOT NULL,
    estado_partido BOOLEAN DEFAULT TRUE
);
CREATE TABLE detalle_partido (
    id_detalle_partido INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    equipo_visitante VARCHAR(30) NOT NULL,
    clima VARCHAR(27) NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);
CREATE TABLE incentivos (
    id_incentivo INT AUTO_INCREMENT PRIMARY KEY,
    id_personal INT NOT NULL,
    id_partido INT NOT NULL,
    motivo VARCHAR(100) NOT NULL,
    monto INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);
CREATE TABLE producto_vendedor (
    id_prod_ven INT AUTO_INCREMENT PRIMARY KEY,
    id_local_prod INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    cantidad_restante INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_local_prod) REFERENCES inventario_local_productos(id_local_prod)
);
CREATE TABLE material_vendedor (
    id_mate_ven INT AUTO_INCREMENT PRIMARY KEY,
    id_local_mate INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_asignada INT NOT NULL,
    cantidad_restante INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_local_mate) REFERENCES inventario_local_material(id_local_mate)
);
CREATE TABLE asistencias (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_personal INT NOT NULL,
    id_partido INT NOT NULL,
    asistio BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);
CREATE TABLE mermas (
    id_merma INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    motivo VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
CREATE TABLE mermas_vendedor (
    id_merma_vend INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    motivo VARCHAR(58) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

/*___________________________________________________________*/

CREATE TABLE ventas (
	id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL
);
CREATE TABLE detalle_venta (
	id_det_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio INT NOT NULL,
    total INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);
CREATE TABLE comisiones (
    id_comision INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    porcentaje DECIMAL NOT NULL,
    monto_calculado DECIMAL NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);
CREATE TABLE devoluciones (
    id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    motivo VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);
CREATE TABLE pagos (
	id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    monto INT NOT NULL,
    metodo_pago VARCHAR(40) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);

/*__________________________________________________________*/

CREATE TABLE reportes (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    fecha_generacion DATE NOT NULL,
    observaciones VARCHAR(105) NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);
CREATE TABLE detalle_reporte (
    id_detal_rep_per INT AUTO_INCREMENT PRIMARY KEY,
    id_reporte INT NOT NULL,
    id_personal INT NOT NULL,
    id_producto INT NOT NULL,
    id_venta INT NOT NULL,
    id_comision INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    total_vendido INT NOT NULL,
    total_comisiones INT NOT NULL,
    FOREIGN KEY (id_reporte) REFERENCES reportes(id_reporte),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_comision) REFERENCES comisiones(id_comision)
);
CREATE TABLE hoja_trabajo (
    id_hoja INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    id_personal INT NOT NULL,
    id_local INT NOT NULL,
    id_venta INT NOT NULL,
    id_comision INT NOT NULL,
    id_devolucion INT NOT NULL,
    fecha_hoja DATE NOT NULL,
    fondo_inicial INT NOT NULL,
    total_vendido INT NOT NULL,
    total_abonos INT NOT NULL,
    total_devoluciones INT NOT NULL,
    total_comisiones INT NOT NULL,
    total_efec_entragado INT NOT NULL,
    estado_hoja BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_local) REFERENCES locales(id_local),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_comision) REFERENCES comisiones(id_comision),
    FOREIGN KEY (id_devolucion) REFERENCES devoluciones(id_devolucion)
);
CREATE TABLE detalle_hoja_producto (
    id_detalle_produ INT AUTO_INCREMENT PRIMARY KEY,
    id_hoja INT NOT NULL,
    id_producto INT NOT NULL,
    id_venta INT NOT NULL,
    id_devolucion INT NOT NULL,
    id_merma_vend INT NOT NULL,
    cantidad_inicial INT NOT NULL,
    cantidad_total INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    cantidad_devuelta INT NOT NULL,
    cantidad_mermas INT NOT NULL,
    cantidad_final INT NOT NULL,
    subtotal INT NOT NULL,
    FOREIGN KEY (id_hoja) REFERENCES hoja_trabajo(id_hoja),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_devolucion) REFERENCES devoluciones(id_devolucion),
    FOREIGN KEY (id_merma_vend) REFERENCES mermas_vendedor(id_merma_vend)
);
CREATE TABLE asignacion_final (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_partido INT NOT NULL,
    id_personal INT NOT NULL,
    rol_final VARCHAR(20) NOT NULL,
    reemplaza_a VARCHAR(30) NULL,
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);
