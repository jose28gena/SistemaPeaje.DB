-- ============================================
-- Procedimiento: sp_RegistrarTransaccion
-- Descripción: Registra una nueva transacción de peaje
-- ============================================

USE [SistemaPeaje]
GO

CREATE PROCEDURE [peaje].[sp_RegistrarTransaccion]
    @EstacionID INT,
    @CarrilID INT,
    @TipoVehiculoID INT,
    @Placa NVARCHAR(20) = NULL,
    @MetodoPago NVARCHAR(20),
    @OperadorID NVARCHAR(50) = NULL,
    @Observaciones NVARCHAR(500) = NULL,
    @TransaccionID BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @MontoTarifa DECIMAL(10,2);
    DECLARE @NumeroTicket NVARCHAR(50);
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Obtener la tarifa vigente
        SELECT @MontoTarifa = t.Monto
        FROM [peaje].[Tarifas] t
        WHERE t.EstacionID = @EstacionID
            AND t.TipoVehiculoID = @TipoVehiculoID
            AND t.Activo = 1
            AND GETDATE() BETWEEN t.FechaVigenciaInicio AND ISNULL(t.FechaVigenciaFin, '9999-12-31');
        
        IF @MontoTarifa IS NULL
        BEGIN
            RAISERROR('No se encontró tarifa vigente para la estación y tipo de vehículo especificados', 16, 1);
            RETURN;
        END
        
        -- Generar número de ticket
        SET @NumeroTicket = 'TKT' + FORMAT(GETDATE(), 'yyyyMMddHHmmss') + RIGHT('000' + CAST(@CarrilID AS NVARCHAR), 3);
        
        -- Insertar la transacción
        INSERT INTO [peaje].[Transacciones] (
            EstacionID, CarrilID, TipoVehiculoID, Placa, MontoTarifa, 
            MontoPagado, MetodoPago, NumeroTicket, OperadorID, 
            Estado, Observaciones
        )
        VALUES (
            @EstacionID, @CarrilID, @TipoVehiculoID, @Placa, @MontoTarifa,
            @MontoTarifa, @MetodoPago, @NumeroTicket, @OperadorID,
            'Completada', @Observaciones
        );
        
        SET @TransaccionID = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO
