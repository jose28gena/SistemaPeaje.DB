-- ============================================
-- Procedimiento: sp_RegistrarEventoTransito
-- Descripción: Registra eventos de tránsito en tiempo real
-- Módulo: 13 - Monitor de Eventos
-- ============================================

USE [SistemaPeaje]
GO

CREATE PROCEDURE [peaje].[sp_RegistrarEventoTransito]
    @EstacionID INT,
    @CarrilID INT,
    @TipoEvento NVARCHAR(50),
    @PlacaDetectada NVARCHAR(20) = NULL,
    @TarjetaRFID NVARCHAR(50) = NULL,
    @ClaseVehicularDetectada NVARCHAR(10) = NULL,
    @Velocidad DECIMAL(5,2) = NULL,
    @ImagenRuta NVARCHAR(500) = NULL,
    @DatosAdicionales NVARCHAR(MAX) = NULL,
    @EventoID BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        INSERT INTO [peaje].[EventosTransito] (
            EstacionID, CarrilID, TipoEvento, PlacaDetectada,
            TarjetaRFID, ClaseVehicularDetectada, Velocidad,
            ImagenRuta, DatosAdicionales
        )
        VALUES (
            @EstacionID, @CarrilID, @TipoEvento, @PlacaDetectada,
            @TarjetaRFID, @ClaseVehicularDetectada, @Velocidad,
            @ImagenRuta, @DatosAdicionales
        );
        
        SET @EventoID = SCOPE_IDENTITY();
        
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO
