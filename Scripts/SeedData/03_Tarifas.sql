-- ============================================
-- Script: Datos Iniciales - Tarifas
-- Descripción: Insertar tarifas iniciales
-- ============================================

USE [SistemaPeaje]
GO

-- Insertar tarifas para todas las estaciones y tipos de vehículo
DECLARE @EstacionID INT;
DECLARE @TipoVehiculoID INT;

DECLARE estaciones_cursor CURSOR FOR 
    SELECT EstacionID FROM [peaje].[Estaciones] WHERE Activo = 1;

DECLARE tipos_cursor CURSOR FOR 
    SELECT TipoVehiculoID FROM [peaje].[TiposVehiculo] WHERE Activo = 1;

OPEN estaciones_cursor;
FETCH NEXT FROM estaciones_cursor INTO @EstacionID;

WHILE @@FETCH_STATUS = 0
BEGIN
    OPEN tipos_cursor;
    FETCH NEXT FROM tipos_cursor INTO @TipoVehiculoID;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO [peaje].[Tarifas] (EstacionID, TipoVehiculoID, Monto, FechaVigenciaInicio, UsuarioCreacion)
        VALUES (
            @EstacionID, 
            @TipoVehiculoID, 
            CASE @TipoVehiculoID
                WHEN 1 THEN 5000.00   -- CAT1
                WHEN 2 THEN 10000.00  -- CAT2
                WHEN 3 THEN 15000.00  -- CAT3
                WHEN 4 THEN 20000.00  -- CAT4
                WHEN 5 THEN 25000.00  -- CAT5
                WHEN 6 THEN 30000.00  -- CAT6
                ELSE 5000.00
            END,
            '2025-01-01',
            'SYSTEM'
        );
        
        FETCH NEXT FROM tipos_cursor INTO @TipoVehiculoID;
    END
    
    CLOSE tipos_cursor;
    FETCH NEXT FROM estaciones_cursor INTO @EstacionID;
END

CLOSE estaciones_cursor;
DEALLOCATE estaciones_cursor;
DEALLOCATE tipos_cursor;

PRINT 'Tarifas insertadas correctamente';
GO
