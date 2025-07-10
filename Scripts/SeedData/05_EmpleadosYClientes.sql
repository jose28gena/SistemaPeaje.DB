-- ============================================
-- Script: Datos Iniciales - Empleados y Clientes
-- Descripción: Insertar empleados y clientes de ejemplo
-- ============================================

USE [SistemaPeaje]
GO

-- Insertar empleados de ejemplo
INSERT INTO [peaje].[Empleados] (
    NumeroEmpleado, Nombres, Apellidos, Email, Telefono, 
    Puesto, Departamento, EstacionAsignadaID, FechaIngreso, 
    Salario, UsuarioCreacion
)
VALUES 
    ('EMP001', 'Juan Carlos', 'Pérez García', 'jperez@peaje.com', '555-0101', 
     'Operador de Caseta', 'Operaciones', 1, '2025-01-01', 15000.00, 'SYSTEM'),
    ('EMP002', 'María Elena', 'González López', 'mgonzalez@peaje.com', '555-0102', 
     'Operador de Caseta', 'Operaciones', 1, '2025-01-01', 15000.00, 'SYSTEM'),
    ('EMP003', 'Carlos Alberto', 'Rodríguez Martín', 'crodriguez@peaje.com', '555-0103', 
     'Supervisor de Estación', 'Operaciones', 1, '2025-01-01', 25000.00, 'SYSTEM'),
    ('EMP004', 'Ana Patricia', 'López Hernández', 'alopez@peaje.com', '555-0104', 
     'Operador de Caseta', 'Operaciones', 2, '2025-01-01', 15000.00, 'SYSTEM'),
    ('EMP005', 'Roberto', 'Martínez Silva', 'rmartinez@peaje.com', '555-0105', 
     'Administrador de Sistema', 'Tecnología', NULL, '2025-01-01', 35000.00, 'SYSTEM');

PRINT 'Empleados insertados correctamente';

-- Insertar clientes de ejemplo
INSERT INTO [peaje].[Clientes] (
    RFC, RazonSocial, NombreComercial, Email, Telefono, 
    Direccion, CodigoPostal, Ciudad, Estado, TipoCliente, UsuarioCreacion
)
VALUES 
    ('XAXX010101000', 'Público en General', 'Público en General', NULL, NULL, 
     NULL, NULL, NULL, NULL, 'Individual', 'SYSTEM'),
    ('CORP850101ABC', 'Transportes del Norte SA de CV', 'Transportes del Norte', 
     'facturacion@transportesnorte.com', '555-1001', 
     'Av. Industrial 123, Col. Industrial', '64000', 'Monterrey', 'Nuevo León', 'Corporativo', 'SYSTEM'),
    ('GOBE801201XYZ', 'Gobierno del Estado de Nuevo León', 'Gobierno Estatal', 
     'facturacion@nl.gob.mx', '555-2001', 
     'Palacio de Gobierno S/N', '64000', 'Monterrey', 'Nuevo León', 'Gobierno', 'SYSTEM');

PRINT 'Clientes insertados correctamente';

-- Insertar tarjetas RFID de ejemplo
INSERT INTO [peaje].[TarjetasRFID] (
    NumeroTarjeta, ClienteID, TipoTarjeta, SaldoActual, 
    FechaVencimiento, Estado, UsuarioCreacion
)
VALUES 
    ('RFID001234567890', 2, 'Corporativa', 5000.00, '2025-12-31', 'Activa', 'SYSTEM'),
    ('RFID001234567891', 3, 'Residente', 1000.00, '2025-12-31', 'Activa', 'SYSTEM'),
    ('RFID001234567892', NULL, 'Prepago', 500.00, '2025-12-31', 'Activa', 'SYSTEM'),
    ('RFID001234567893', NULL, 'Prepago', 750.00, '2025-12-31', 'Activa', 'SYSTEM');

PRINT 'Tarjetas RFID insertadas correctamente';
GO
