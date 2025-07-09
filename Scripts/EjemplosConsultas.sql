-- ============================================
-- Script: Consultas de Ejemplo
-- Descripción: Ejemplos de uso del sistema
-- ============================================

USE [SistemaPeaje]
GO

-- =============================================
-- CONSULTAS DE EJEMPLO
-- =============================================

-- 1. Obtener todas las estaciones activas con sus carriles
SELECT 
    e.Codigo AS CodigoEstacion,
    e.Nombre AS NombreEstacion,
    e.Ubicacion,
    c.NumeroCarril,
    c.TipoCarril,
    c.Activo AS CarrilActivo
FROM peaje.Estaciones e
    INNER JOIN peaje.Carriles c ON e.EstacionID = c.EstacionID
WHERE e.Activo = 1
ORDER BY e.Codigo, c.NumeroCarril;

-- 2. Consultar tarifas vigentes por estación
SELECT 
    e.Codigo AS CodigoEstacion,
    e.Nombre AS NombreEstacion,
    tv.Codigo AS TipoVehiculo,
    tv.Descripcion,
    t.Monto,
    t.FechaVigenciaInicio,
    t.FechaVigenciaFin
FROM peaje.Tarifas t
    INNER JOIN peaje.Estaciones e ON t.EstacionID = e.EstacionID
    INNER JOIN peaje.TiposVehiculo tv ON t.TipoVehiculoID = tv.TipoVehiculoID
WHERE t.Activo = 1
    AND GETDATE() BETWEEN t.FechaVigenciaInicio AND ISNULL(t.FechaVigenciaFin, '9999-12-31')
ORDER BY e.Codigo, tv.Codigo;

-- 3. Resumen de transacciones del día actual
SELECT 
    e.Codigo AS Estacion,
    COUNT(*) AS TotalTransacciones,
    SUM(t.MontoTarifa) AS IngresosTarifas,
    SUM(t.MontoPagado) AS IngresosPagados,
    AVG(t.MontoTarifa) AS PromedioTarifa
FROM peaje.Transacciones t
    INNER JOIN peaje.Estaciones e ON t.EstacionID = e.EstacionID
WHERE CAST(t.FechaHora AS DATE) = CAST(GETDATE() AS DATE)
    AND t.Estado = 'Completada'
GROUP BY e.Codigo, e.Nombre
ORDER BY e.Codigo;

-- 4. Transacciones por método de pago (últimos 7 días)
SELECT 
    t.MetodoPago,
    COUNT(*) AS CantidadTransacciones,
    SUM(t.MontoPagado) AS TotalIngresos,
    AVG(t.MontoPagado) AS PromedioTransaccion
FROM peaje.Transacciones t
WHERE t.FechaHora >= DATEADD(day, -7, GETDATE())
    AND t.Estado = 'Completada'
GROUP BY t.MetodoPago
ORDER BY CantidadTransacciones DESC;

-- 5. Ranking de estaciones por ingresos (mes actual)
SELECT 
    e.Codigo,
    e.Nombre,
    COUNT(t.TransaccionID) AS NumeroTransacciones,
    SUM(t.MontoPagado) AS TotalIngresos,
    RANK() OVER (ORDER BY SUM(t.MontoPagado) DESC) AS Ranking
FROM peaje.Estaciones e
    INNER JOIN peaje.Transacciones t ON e.EstacionID = t.EstacionID
WHERE YEAR(t.FechaHora) = YEAR(GETDATE())
    AND MONTH(t.FechaHora) = MONTH(GETDATE())
    AND t.Estado = 'Completada'
GROUP BY e.Codigo, e.Nombre
ORDER BY TotalIngresos DESC;

-- =============================================
-- EJEMPLOS DE USO DE PROCEDIMIENTOS
-- =============================================

-- Ejemplo: Registrar una nueva transacción
DECLARE @TransaccionID BIGINT;

EXEC peaje.sp_RegistrarTransaccion
    @EstacionID = 1,
    @CarrilID = 1,
    @TipoVehiculoID = 1,
    @Placa = 'ABC123',
    @MetodoPago = 'Efectivo',
    @OperadorID = 'OPERADOR01',
    @Observaciones = 'Transacción de prueba',
    @TransaccionID = @TransaccionID OUTPUT;

SELECT @TransaccionID AS NuevaTransaccionID;

-- =============================================
-- EJEMPLOS DE USO DE FUNCIONES
-- =============================================

-- Ejemplo: Obtener tarifa vigente
SELECT 
    peaje.fn_ObtenerTarifaVigente(1, 1, GETDATE()) AS TarifaVigente;

-- Verificar tarifas para todos los tipos de vehículo en una estación
SELECT 
    tv.Codigo,
    tv.Descripcion,
    peaje.fn_ObtenerTarifaVigente(1, tv.TipoVehiculoID, GETDATE()) AS Tarifa
FROM peaje.TiposVehiculo tv
WHERE tv.Activo = 1
ORDER BY tv.TipoVehiculoID;
