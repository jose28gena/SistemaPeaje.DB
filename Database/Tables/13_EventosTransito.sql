-- ============================================
-- Tabla: peaje.EventosTransito
-- Descripción: Log de eventos de tránsito en tiempo real
-- Módulo: 13 - Monitor de Eventos
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[EventosTransito] (
    [EventoID] BIGINT IDENTITY(1,1) NOT NULL,
    [EstacionID] INT NOT NULL,
    [CarrilID] INT NOT NULL,
    [TipoEvento] NVARCHAR(50) NOT NULL, -- 'VehiculoDetectado', 'PagoRealizado', 'BarreraAbierta', 'Error'
    [FechaHora] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [PlacaDetectada] NVARCHAR(20) NULL,
    [TarjetaRFID] NVARCHAR(50) NULL,
    [ClaseVehicularDetectada] NVARCHAR(10) NULL,
    [Velocidad] DECIMAL(5,2) NULL,
    [ImagenRuta] NVARCHAR(500) NULL,
    [DatosAdicionales] NVARCHAR(MAX) NULL, -- JSON con datos extra
    [Procesado] BIT NOT NULL DEFAULT 0,
    [TransaccionID] BIGINT NULL,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    
    CONSTRAINT [PK_EventosTransito] PRIMARY KEY CLUSTERED ([EventoID]),
    CONSTRAINT [FK_EventosTransito_Estaciones] FOREIGN KEY ([EstacionID]) 
        REFERENCES [peaje].[Estaciones]([EstacionID]),
    CONSTRAINT [FK_EventosTransito_Carriles] FOREIGN KEY ([CarrilID]) 
        REFERENCES [peaje].[Carriles]([CarrilID]),
    CONSTRAINT [FK_EventosTransito_Transacciones] FOREIGN KEY ([TransaccionID]) 
        REFERENCES [peaje].[Transacciones]([TransaccionID])
)
GO

-- Índices optimizados para tiempo real
CREATE NONCLUSTERED INDEX [IX_EventosTransito_FechaHora] ON [peaje].[EventosTransito] ([FechaHora] DESC)
CREATE NONCLUSTERED INDEX [IX_EventosTransito_EstacionCarril] ON [peaje].[EventosTransito] ([EstacionID], [CarrilID], [FechaHora] DESC)
CREATE NONCLUSTERED INDEX [IX_EventosTransito_TipoEvento] ON [peaje].[EventosTransito] ([TipoEvento], [FechaHora] DESC)
CREATE NONCLUSTERED INDEX [IX_EventosTransito_Procesado] ON [peaje].[EventosTransito] ([Procesado]) WHERE [Procesado] = 0
GO
