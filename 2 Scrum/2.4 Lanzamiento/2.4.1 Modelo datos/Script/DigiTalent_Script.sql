-- Creación de la base de datos Digitalent

CREATE DATABASE digitalent_db;
\c digitalent_db

CREATE SEQUENCE tipo_discapacidad_id_seq;
CREATE SEQUENCE usuario_id_seq;
CREATE SEQUENCE plan_empresa_id_seq;
CREATE SEQUENCE empresa_id_seq;
CREATE SEQUENCE suscripcion_empresa_id_seq;
CREATE SEQUENCE banner_publicidad_id_seq;
CREATE SEQUENCE vacante_id_seq;
CREATE SEQUENCE postulacion_id_seq;
CREATE SEQUENCE contenido_educativo_id_seq;
CREATE SEQUENCE notificacion_id_seq;
CREATE SEQUENCE suscripcion_usuario_id_seq;

CREATE TABLE TipoDiscapacidad (
    idDiscapacidad INT PRIMARY KEY DEFAULT nextval('tipo_discapacidad_id_seq'),
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY DEFAULT nextval('usuario_id_seq'),
    idDiscapacidad INT,
    apellido VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    dni CHAR(8) UNIQUE NOT NULL,
    tipoUsuario VARCHAR(20),
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(100) NOT NULL,
    celular VARCHAR(15),
    codigoConadis VARCHAR(50),
    habilidades VARCHAR(500),
    premiumActivo BOOLEAN NOT NULL,
    fechaRegistro TIMESTAMPTZ NOT NULL,
    usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ,
    fechaModificacion TIMESTAMPTZ,
    FOREIGN KEY (idDiscapacidad) REFERENCES TipoDiscapacidad (idDiscapacidad)
);

CREATE TABLE PlanEmpresa (
    idPlan INT PRIMARY KEY DEFAULT nextval('plan_empresa_id_seq'),
    nombre VARCHAR(50) NOT NULL,
    precio NUMERIC(18, 2) NOT NULL,
    duracionMes INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY DEFAULT nextval('empresa_id_seq'),
    nombre VARCHAR(100) NOT NULL,
    ruc CHAR(20) UNIQUE NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    distrito VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    fechaRegistro TIMESTAMPTZ NOT NULL,
    usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ,
    fechaModificacion TIMESTAMPTZ
);

CREATE TABLE SuscripcionEmpresa (
    idSuscripcion INT PRIMARY KEY DEFAULT nextval('suscripcion_empresa_id_seq'),
    idEmpresa INT NOT NULL,
    idPlan INT NOT NULL,
    fechaInicio TIMESTAMPTZ NOT NULL,
    fechaFin TIMESTAMPTZ NOT NULL,
    fecCancelacion TIMESTAMPTZ,
    estado VARCHAR(20) NOT NULL,
    usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ,
    fechaModificacion TIMESTAMPTZ,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa (idEmpresa),
    FOREIGN KEY (idPlan) REFERENCES PlanEmpresa (idPlan)
);

CREATE TABLE BannerPublicidad (
    idBanner INT PRIMARY KEY DEFAULT nextval('banner_publicidad_id_seq'),
    idEmpresa INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    imagenURL VARCHAR(255) NOT NULL,
    enlace VARCHAR(255) NOT NULL,
    fechaInicio TIMESTAMPTZ NOT NULL,
    fechaFin TIMESTAMPTZ NOT NULL,
    estado BOOLEAN NOT NULL,
    usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ,
    fechaModificacion TIMESTAMPTZ,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Vacante (
    idVacante INT PRIMARY KEY DEFAULT nextval('vacante_id_seq'),
    idEmpresa INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    ubicacion VARCHAR(100) NOT NULL,
    discRequerida VARCHAR(100) NOT NULL,
    habRequerida VARCHAR(100) NOT NULL,
    fechaPublicacion TIMESTAMPTZ NOT NULL,
    estado BOOLEAN NOT NULL,
    usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ,
    fechaModificacion TIMESTAMPTZ,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Postulacion (
    idPostulacion INT PRIMARY KEY DEFAULT nextval('postulacion_id_seq'),
    idUsuario INT NOT NULL,
    idVacante INT NOT NULL,
    fechaPostulacion TIMESTAMPTZ NOT NULL,
    estado VARCHAR(20) NOT NULL,
    usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ,
    fechaModificacion TIMESTAMPTZ,
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario),
    FOREIGN KEY (idVacante) REFERENCES Vacante (idVacante)
);

CREATE TABLE ContenidoEducativo (
    idContenido INT PRIMARY KEY DEFAULT nextval('contenido_educativo_id_seq'),
    idDiscapacidad INT,
    titulo VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    enlaceExterno VARCHAR(150) NOT NULL,
    fechaPublicacion TIMESTAMPTZ NOT NULL,
    estado BOOLEAN NOT NULL,
    usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ,
    fechaModificacion TIMESTAMPTZ,
    FOREIGN KEY (idDiscapacidad) REFERENCES TipoDiscapacidad(idDiscapacidad)
);

CREATE TABLE Notificacion (
    idNotificacion INT PRIMARY KEY DEFAULT nextval('notificacion_id_seq'),
    idEmpresa INT,
    idUsuario INT,
    titulo VARCHAR(50) NOT NULL,
    mensaje VARCHAR(500) NOT NULL,
    fechaEnvio TIMESTAMPTZ,
	usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ, 
    fechaModificacion TIMESTAMPTZ,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE SuscripcionUsuario (
    idSuscripcion INT PRIMARY KEY DEFAULT nextval('suscripcion_usuario_id_seq'),
    idUsuario INT NOT NULL,
    fechaInicio TIMESTAMPTZ NOT NULL,
    fechaFin TIMESTAMPTZ NOT NULL,
    fecCancelacion TIMESTAMPTZ,
    precio NUMERIC(18,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    usuCreacion VARCHAR(100),
    usuModificacion VARCHAR(100),
    fechaCreacion TIMESTAMPTZ,
    fechaModificacion TIMESTAMPTZ,
    FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario)
);

ALTER SEQUENCE tipo_discapacidad_id_seq OWNED BY TipoDiscapacidad.idDiscapacidad;
ALTER SEQUENCE usuario_id_seq OWNED BY Usuario.idUsuario;
ALTER SEQUENCE plan_empresa_id_seq OWNED BY PlanEmpresa.idPlan;
ALTER SEQUENCE empresa_id_seq OWNED BY Empresa.idEmpresa;
ALTER SEQUENCE suscripcion_empresa_id_seq OWNED BY SuscripcionEmpresa.idSuscripcion;
ALTER SEQUENCE banner_publicidad_id_seq OWNED BY BannerPublicidad.idBanner;
ALTER SEQUENCE vacante_id_seq OWNED BY Vacante.idVacante;
ALTER SEQUENCE postulacion_id_seq OWNED BY Postulacion.idPostulacion;
ALTER SEQUENCE contenido_educativo_id_seq OWNED BY ContenidoEducativo.idContenido;
ALTER SEQUENCE notificacion_id_seq OWNED BY Notificacion.idNotificacion;
ALTER SEQUENCE suscripcion_usuario_id_seq OWNED BY SuscripcionUsuario.idSuscripcion;



CREATE OR REPLACE FUNCTION set_auditoria_insert()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fechaCreacion := NOW();
    NEW.usuCreacion := current_user;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION set_auditoria_update()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fechaModificacion := NOW();
    NEW.usuModificacion := current_user;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_usuario_insert
BEFORE INSERT ON Usuario
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_usuario_update
BEFORE UPDATE ON Usuario
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();

CREATE TRIGGER trg_empresa_insert
BEFORE INSERT ON Empresa
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_empresa_update
BEFORE UPDATE ON Empresa
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();

CREATE TRIGGER trg_vacante_insert
BEFORE INSERT ON Vacante
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_vacante_update
BEFORE UPDATE ON Vacante
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();

CREATE TRIGGER trg_postulacion_insert
BEFORE INSERT ON Postulacion
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_postulacion_update
BEFORE UPDATE ON Postulacion
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();

CREATE TRIGGER trg_banner_insert
BEFORE INSERT ON BannerPublicidad
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_banner_update
BEFORE UPDATE ON BannerPublicidad
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();

CREATE TRIGGER trg_notificacion_insert
BEFORE INSERT ON Notificacion
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_notificacion_update
BEFORE UPDATE ON Notificacion
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();

CREATE TRIGGER trg_suscripcion_usuario_insert
BEFORE INSERT ON SuscripcionUsuario
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_suscripcion_usuario_update
BEFORE UPDATE ON SuscripcionUsuario
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();

CREATE TRIGGER trg_suscripcion_empresa_insert
BEFORE INSERT ON SuscripcionEmpresa
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_suscripcion_empresa_update
BEFORE UPDATE ON SuscripcionEmpresa
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();

CREATE TRIGGER trg_contenido_educativo_insert
BEFORE INSERT ON ContenidoEducativo
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_insert();

CREATE TRIGGER trg_contenido_educativo_update
BEFORE UPDATE ON ContenidoEducativo
FOR EACH ROW
EXECUTE FUNCTION set_auditoria_update();