-- ============================================
-- Script: Datos Iniciales - Estaciones
-- Descripción: Insertar estaciones de peaje de ejemplo
-- ============================================

USE [SistemaPeaje]
GO

-- Insertar estaciones de ejemplo
INSERT INTO [peaje].[Estaciones] (Codigo, Nombre, Ubicacion, Kilometro, UsuarioCreacion)
VALUES 
    ('EST001', 'Peaje Norte', 'Autopista Norte Km 25', 25.00, 'SYSTEM'),
    ('EST002', 'Peaje Sur', 'Autopista Sur Km 45', 45.00, 'SYSTEM'),
    ('EST003', 'Peaje Este', 'Autopista Este Km 30', 30.00, 'SYSTEM'),
    ('EST004', 'Peaje Oeste', 'Autopista Oeste Km 35', 35.00, 'SYSTEM');

PRINT 'Estaciones insertadas correctamente';

-- Insertar carriles para cada estación
DECLARE @EstacionID INT;
DECLARE @Contador INT;

-- Carriles para Estación Norte
SELECT @EstacionID = EstacionID FROM [peaje].[Estaciones] WHERE Codigo = 'EST001';
SET @Contador = 1;
WHILE @Contador <= 4
BEGIN
    INSERT INTO [peaje].[Carriles] (EstacionID, NumeroCarril, TipoCarril, UsuarioCreacion)
    VALUES (@EstacionID, @Contador, 
            CASE 
                WHEN @Contador = 1 THEN 'Telepeaje'
                WHEN @Contador = 4 THEN 'Automatico'
                ELSE 'Manual'
            END, 'SYSTEM');
    SET @Contador = @Contador + 1;
END

-- Carriles para Estación Sur
SELECT @EstacionID = EstacionID FROM [peaje].[Estaciones] WHERE Codigo = 'EST002';
SET @Contador = 1;
WHILE @Contador <= 3
BEGIN
    INSERT INTO [peaje].[Carriles] (EstacionID, NumeroCarril, TipoCarril, UsuarioCreacion)
    VALUES (@EstacionID, @Contador, 
            CASE 
                WHEN @Contador = 1 THEN 'Telepeaje'
                ELSE 'Manual'
            END, 'SYSTEM');
    SET @Contador = @Contador + 1;
END

PRINT 'Carriles insertados correctamente';
GO
