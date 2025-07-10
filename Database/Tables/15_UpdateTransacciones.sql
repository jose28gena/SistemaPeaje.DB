-- ============================================
-- Script: Actualizar tabla Transacciones
-- Descripción: Añadir nuevas columnas para módulos expandidos
-- ============================================

USE [SistemaPeaje]
GO

-- Añadir nuevas columnas a la tabla Transacciones
ALTER TABLE [peaje].[Transacciones] 
ADD [TurnoID] INT NULL,
    [TarjetaRFID] NVARCHAR(50) NULL,
    [TipoPagoID] INT NULL,
    [ClaseVehicularDetectada] NVARCHAR(10) NULL,
    [ImagenComprobante] NVARCHAR(500) NULL,
    [EventoOrigenID] BIGINT NULL;

-- Añadir llaves foráneas
ALTER TABLE [peaje].[Transacciones] 
ADD CONSTRAINT [FK_Transacciones_Turnos] 
    FOREIGN KEY ([TurnoID]) REFERENCES [peaje].[Turnos]([TurnoID]);

ALTER TABLE [peaje].[Transacciones] 
ADD CONSTRAINT [FK_Transacciones_TiposPago] 
    FOREIGN KEY ([TipoPagoID]) REFERENCES [peaje].[TiposPago]([TipoPagoID]);

ALTER TABLE [peaje].[Transacciones] 
ADD CONSTRAINT [FK_Transacciones_EventosTransito] 
    FOREIGN KEY ([EventoOrigenID]) REFERENCES [peaje].[EventosTransito]([EventoID]);

-- Añadir índices para las nuevas columnas
CREATE NONCLUSTERED INDEX [IX_Transacciones_TurnoID] ON [peaje].[Transacciones] ([TurnoID])
CREATE NONCLUSTERED INDEX [IX_Transacciones_TarjetaRFID] ON [peaje].[Transacciones] ([TarjetaRFID])
CREATE NONCLUSTERED INDEX [IX_Transacciones_EventoOrigenID] ON [peaje].[Transacciones] ([EventoOrigenID])
GO

PRINT 'Tabla Transacciones actualizada con nuevas columnas'
