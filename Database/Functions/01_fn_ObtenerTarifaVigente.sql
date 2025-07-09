-- ============================================
-- Función: fn_ObtenerTarifaVigente
-- Descripción: Obtiene la tarifa vigente para una estación y tipo de vehículo
-- ============================================

USE [SistemaPeaje]
GO

CREATE FUNCTION [peaje].[fn_ObtenerTarifaVigente]
(
    @EstacionID INT,
    @TipoVehiculoID INT,
    @Fecha DATE = NULL
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Tarifa DECIMAL(10,2);
    
    IF @Fecha IS NULL
        SET @Fecha = GETDATE();
    
    SELECT @Tarifa = t.Monto
    FROM [peaje].[Tarifas] t
    WHERE t.EstacionID = @EstacionID
        AND t.TipoVehiculoID = @TipoVehiculoID
        AND t.Activo = 1
        AND @Fecha BETWEEN t.FechaVigenciaInicio AND ISNULL(t.FechaVigenciaFin, '9999-12-31');
    
    RETURN ISNULL(@Tarifa, 0);
END
GO
