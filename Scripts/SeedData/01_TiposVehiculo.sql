-- ============================================
-- Script: Datos Iniciales - Tipos de Vehículo
-- Descripción: Insertar tipos de vehículo predefinidos
-- ============================================

USE [SistemaPeaje]
GO

-- Insertar tipos de vehículo
INSERT INTO [peaje].[TiposVehiculo] (Codigo, Descripcion, NumeroEjes, UsuarioCreacion)
VALUES 
    ('CAT1', 'Categoría 1 - Automóviles, camionetas y motocicletas', 2, 'SYSTEM'),
    ('CAT2', 'Categoría 2 - Buses y camiones 2 ejes', 2, 'SYSTEM'),
    ('CAT3', 'Categoría 3 - Camiones 3 ejes', 3, 'SYSTEM'),
    ('CAT4', 'Categoría 4 - Camiones 4 ejes', 4, 'SYSTEM'),
    ('CAT5', 'Categoría 5 - Camiones 5 ejes', 5, 'SYSTEM'),
    ('CAT6', 'Categoría 6 - Camiones 6 o más ejes', 6, 'SYSTEM');

PRINT 'Tipos de vehículo insertados correctamente';
GO
