-- ============================================
-- Script: Datos Iniciales - Clases Vehiculares
-- Descripción: Insertar clases vehiculares estándar
-- ============================================

USE [SistemaPeaje]
GO

-- Insertar clases vehiculares
INSERT INTO [peaje].[ClasesVehiculares] (Codigo, Descripcion, NumeroEjes, PesoMaximo, AltoMaximo, UsuarioCreacion)
VALUES 
    ('AUTO', 'Automóviles y motocicletas', 2, 3.5, 2.10, 'SYSTEM'),
    ('2EJ', 'Vehículos de 2 ejes', 2, 7.5, 4.25, 'SYSTEM'),
    ('3EJ', 'Vehículos de 3 ejes', 3, 23.0, 4.25, 'SYSTEM'),
    ('4EJ', 'Vehículos de 4 ejes', 4, 31.0, 4.25, 'SYSTEM'),
    ('5EJ', 'Vehículos de 5 ejes', 5, 38.5, 4.25, 'SYSTEM'),
    ('6EJ', 'Vehículos de 6 ejes', 6, 46.0, 4.25, 'SYSTEM'),
    ('7EJ', 'Vehículos de 7 ejes', 7, 53.5, 4.25, 'SYSTEM'),
    ('8EJ', 'Vehículos de 8 ejes', 8, 61.0, 4.25, 'SYSTEM'),
    ('9EJ', 'Vehículos de 9 ejes o más', 9, 68.5, 4.25, 'SYSTEM');

PRINT 'Clases vehiculares insertadas correctamente';

-- Insertar tipos de pago
INSERT INTO [peaje].[TiposPago] (Codigo, Descripcion, RequiereTarjeta, PermiteCredito, UsuarioCreacion)
VALUES 
    ('EFECTIVO', 'Pago en efectivo', 0, 0, 'SYSTEM'),
    ('TARJETA', 'Pago con tarjeta de crédito/débito', 0, 1, 'SYSTEM'),
    ('PREPAGO', 'Tarjeta prepago RFID', 1, 0, 'SYSTEM'),
    ('RESIDENTE', 'Tarjeta de residente', 1, 1, 'SYSTEM'),
    ('CORPORATIVO', 'Cuenta corporativa', 1, 1, 'SYSTEM'),
    ('TELEPEAJE', 'Sistema de telepeaje automático', 1, 1, 'SYSTEM');

PRINT 'Tipos de pago insertados correctamente';

-- Actualizar tipos de vehículo existentes con clases vehiculares
UPDATE tv SET ClaseVehicularID = cv.ClaseVehicularID
FROM [peaje].[TiposVehiculo] tv
INNER JOIN [peaje].[ClasesVehiculares] cv ON tv.Codigo = CASE 
    WHEN tv.Codigo = 'CAT1' THEN 'AUTO'
    WHEN tv.Codigo = 'CAT2' THEN '2EJ'
    WHEN tv.Codigo = 'CAT3' THEN '3EJ'
    WHEN tv.Codigo = 'CAT4' THEN '4EJ'
    WHEN tv.Codigo = 'CAT5' THEN '5EJ'
    WHEN tv.Codigo = 'CAT6' THEN '6EJ'
END;

PRINT 'Tipos de vehículo actualizados con clases vehiculares';
GO
