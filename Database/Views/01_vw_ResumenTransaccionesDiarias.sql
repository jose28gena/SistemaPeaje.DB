-- ============================================
-- Vista: vw_ResumenTransaccionesDiarias
-- Descripción: Resumen de transacciones por día y estación
-- ============================================

USE [SistemaPeaje]
GO

CREATE VIEW [peaje].[vw_ResumenTransaccionesDiarias]
AS
SELECT 
    e.Codigo AS CodigoEstacion,
    e.Nombre AS NombreEstacion,
    CAST(t.FechaHora AS DATE) AS Fecha,
    tv.Codigo AS TipoVehiculo,
    tv.Descripcion AS DescripcionVehiculo,
    COUNT(*) AS CantidadTransacciones,
    SUM(t.MontoTarifa) AS TotalTarifas,
    SUM(t.MontoPagado) AS TotalPagado,
    AVG(t.MontoTarifa) AS PromedioTarifa
FROM [peaje].[Transacciones] t
    INNER JOIN [peaje].[Estaciones] e ON t.EstacionID = e.EstacionID
    INNER JOIN [peaje].[TiposVehiculo] tv ON t.TipoVehiculoID = tv.TipoVehiculoID
WHERE t.Estado = 'Completada'
GROUP BY 
    e.Codigo,
    e.Nombre,
    CAST(t.FechaHora AS DATE),
    tv.Codigo,
    tv.Descripcion
GO
