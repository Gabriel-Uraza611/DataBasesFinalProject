CREATE TABLE RangoSalarial (
    RangoId SERIAL PRIMARY KEY,              -- Identificador único del rango
    RangoSalarial CHAR(1) NOT NULL,          -- Por ejemplo: A, B, C
    SalarioMinimo DECIMAL(10, 2) NOT NULL,   -- Límite inferior del rango
    SalarioMaximo DECIMAL(10, 2) NOT NULL    -- Límite superior del rango
);

CREATE TABLE Cotizante (
    CotizanteId SERIAL PRIMARY KEY,  -- Identificador único del cotizante
    TipoDocumento VARCHAR(50) NOT NULL,          -- Tipo de documento (e.g., CC, TI)
    NumeroDocumento VARCHAR(50) UNIQUE NOT NULL, -- Número de documento único
    Apellidos VARCHAR(100) NOT NULL,             -- Apellidos del cotizante
    Nombres VARCHAR(100) NOT NULL,               -- Nombres del cotizante
    FechaNacimiento DATE NOT NULL,               -- Fecha de nacimiento
    Genero CHAR(1) NOT NULL,                     -- Género (e.g., M, F)
    Direccion VARCHAR(200),                      -- Dirección
    CiudadResidencia VARCHAR(100),               -- Ciudad de residencia
    Telefono VARCHAR(20),                        -- Teléfono
    EstadoCivil VARCHAR(50),                     -- Estado civil
    CorreoElectronico VARCHAR(100),              -- Correo electrónico
    FechaPrimeraAfiliacion DATE,                 -- Fecha de primera afiliación
    EstadoActual TEXT NOT NULL CHECK (EstadoActual IN ('Activo', 'Inactivo', 'Retirado')), -- Estado actual validado
    Salario DECIMAL(10, 2) NOT NULL,             -- Salario exacto
    RangoId INT NOT NULL,                        -- Relación con la tabla Rango Salarial
    FOREIGN KEY (RangoId) REFERENCES RangoSalarial(RangoId) -- Clave foránea
);


CREATE TABLE Empresa (
    EmpresaId SERIAL PRIMARY KEY,     -- Identificador único de la empresa
    NIT VARCHAR(20) NOT NULL UNIQUE,  -- Número de identificación tributaria
    RazonSocial VARCHAR(200) NOT NULL, -- Razón social de la empresa
    Ciudad VARCHAR(100) NOT NULL,      -- Ciudad de la empresa
    Direccion VARCHAR(200),            -- Dirección de la empresa
    Telefono VARCHAR(20),              -- Teléfono de contacto
    NombreContacto VARCHAR(100)        -- Nombre del contacto principal
);


CREATE TABLE Contrato (
    ContratoId SERIAL PRIMARY KEY,                  -- Identificador único del contrato
    FechaRecibido DATE NOT NULL,                    -- Fecha en que se recibió el contrato
    NumeroRadicado VARCHAR(50) UNIQUE NOT NULL,     -- Número de radicado del contrato
    SalarioBase DECIMAL(10, 2) NOT NULL,            -- Salario base del contrato
    EstadoContrato TEXT NOT NULL CHECK (EstadoContrato IN ('Activo', 'Retirado')),  -- Estado del contrato
    TipoAfiliado TEXT NOT NULL CHECK (TipoAfiliado IN ('Dependiente', 'Independiente')), -- Tipo de afiliado
    CotizanteId INT NOT NULL,                       -- Relación con la tabla Cotizante
    EmpresaId INT NOT NULL,                         -- Relación con la tabla Empresa
    FOREIGN KEY (CotizanteId) REFERENCES Cotizante(CotizanteId),
    FOREIGN KEY (EmpresaId) REFERENCES Empresa(EmpresaId)
);

CREATE TABLE Servicio (
    ServicioId SERIAL PRIMARY KEY,      -- Identificador único del servicio
    NombreServicio VARCHAR(200) NOT NULL -- Nombre del servicio   
);

CREATE TABLE IPS (
    IPSId SERIAL PRIMARY KEY,         -- Identificador único de la IPS
    NIT VARCHAR(20) NOT NULL UNIQUE,  -- Número de identificación tributaria de la IPS
    RazonSocial VARCHAR(200) NOT NULL, -- Razón social de la IPS
    NivelAtencion VARCHAR(100),        -- Nivel de atención proporcionado
    ServicioId INT NOT NULL,
    FOREIGN KEY (ServicioId) REFERENCES Servicio(ServicioId)
);

CREATE TABLE Beneficiario (
    BeneficiarioId SERIAL PRIMARY KEY, -- Identificador único del beneficiario
    TipoDocumento VARCHAR(50) NOT NULL, -- Tipo de documento (e.g., CC, TI)
    NumeroDocumento VARCHAR(50) UNIQUE NOT NULL, -- Número de documento único
    Apellidos VARCHAR(100) NOT NULL,  -- Apellidos del beneficiario
    Nombres VARCHAR(100) NOT NULL,    -- Nombres del beneficiario
    FechaNacimiento DATE NOT NULL,    -- Fecha de nacimiento
    Genero CHAR(1) NOT NULL,          -- Género (e.g., M, F)
    Direccion VARCHAR(200),           -- Dirección del beneficiario
    CiudadResidencia VARCHAR(100),    -- Ciudad de residencia
    Telefono VARCHAR(20),             -- Teléfono
    EstadoCivil VARCHAR(50),          -- Estado civil
    CorreoElectronico VARCHAR(100),   -- Correo electrónico
    Parentesco VARCHAR(50) NOT NULL,  -- Parentesco con el cotizante
    CotizanteId INT NOT NULL,         -- Relación con la tabla Cotizante
    FOREIGN KEY (CotizanteId) REFERENCES Cotizante(CotizanteId)
);


CREATE TABLE OrdenServicio (
    OrdenId SERIAL PRIMARY KEY,          -- Identificador único de la orden
    CodigoOrden VARCHAR(50) UNIQUE NOT NULL, -- Código único de la orden
    FechaOrden DATE NOT NULL,            -- Fecha en que se emitió la orden
    NombreMedico VARCHAR(100) NOT NULL,  -- Nombre del médico que emitió la orden
    Diagnostico TEXT NOT NULL,           -- Diagnóstico relacionado con la orden
    CotizanteId INT NOT NULL,            -- Relación con la tabla Cotizante
    IPSId INT NOT NULL,                  -- Relación con la tabla IPS
    FOREIGN KEY (CotizanteId) REFERENCES Cotizante(CotizanteId),
    FOREIGN KEY (IPSId) REFERENCES IPS(IPSId)
);


CREATE TABLE DetalleOrden (
    DetalleId SERIAL PRIMARY KEY,         -- Identificador único del detalle
    OrdenId INT NOT NULL,                 -- Relación con la tabla OrdenServicio
    ServicioId INT NOT NULL,              -- Relación con la tabla Servicio
    FOREIGN KEY (OrdenId) REFERENCES OrdenServicio(OrdenId),
    FOREIGN KEY (ServicioId) REFERENCES Servicio(ServicioId)
);


CREATE TABLE PagoAporte (
    PagoId SERIAL PRIMARY KEY,          -- Identificador único del pago
    FechaPago DATE NOT NULL,            -- Fecha en que se realizó el pago
    ValorPagado DECIMAL(10, 2) NOT NULL, -- Valor del pago realizado
    CotizanteId INT NOT NULL,           -- Relación con la tabla Cotizante
    EmpresaId INT NOT NULL,             -- Relación con la tabla Empresa
    FOREIGN KEY (CotizanteId) REFERENCES Cotizante(CotizanteId),
    FOREIGN KEY (EmpresaId) REFERENCES Empresa(EmpresaId)
);

