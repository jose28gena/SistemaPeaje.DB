-- ============================================
-- Procedimiento: sp_AbrirTurno
-- Descripción: Abre un nuevo turno de trabajo
-- Módulo: 12 - Turnos
-- ============================================

USE [SistemaPeaje]
GO

CREATE PROCEDURE [peaje].[sp_AbrirTurno]
    @EmpleadoID INT,
    @EstacionID INT,
    @CarrilID INT = NULL,
    @MontoInicialEfectivo DECIMAL(10,2) = 0,
    @UsuarioCreacion NVARCHAR(50),
    @TurnoID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @NumeroTurno NVARCHAR(20);
    DECLARE @TurnosAbiertos INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar que el empleado no tenga turnos abiertos
        SELECT @TurnosAbiertos = COUNT(*)
        FROM [peaje].[Turnos]
        WHERE EmpleadoID = @EmpleadoID 
            AND Estado = 'Abierto';
        
        IF @TurnosAbiertos > 0
        BEGIN
            RAISERROR('El empleado ya tiene un turno abierto', 16, 1);
            RETURN;
        END
        
        -- Generar número de turno único
        SET @NumeroTurno = 'T' + FORMAT(GETDATE(), 'yyyyMMddHHmmss') + RIGHT('000' + CAST(@EmpleadoID AS NVARCHAR), 3);
        
        -- Insertar nuevo turno
        INSERT INTO [peaje].[Turnos] (
            NumeroTurno, EmpleadoID, EstacionID, CarrilID, 
            FechaInicio, MontoInicialEfectivo, Estado, UsuarioCreacion
        )
        VALUES (
            @NumeroTurno, @EmpleadoID, @EstacionID, @CarrilID,
            GETDATE(), @MontoInicialEfectivo, 'Abierto', @UsuarioCreacion
        );
        
        SET @TurnoID = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO
