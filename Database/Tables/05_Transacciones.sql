-- ============================================
-- Tabla: peaje.Transacciones
-- Descripción: Registro de todas las transacciones de peaje
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[Transacciones] (
    [TransaccionID] BIGINT IDENTITY(1,1) NOT NULL,
    [EstacionID] INT NOT NULL,
    [CarrilID] INT NOT NULL,
    [TipoVehiculoID] INT NOT NULL,
    [Placa] NVARCHAR(20) NULL,
    [FechaHora] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [MontoTarifa] DECIMAL(10,2) NOT NULL,
    [MontoPagado] DECIMAL(10,2) NOT NULL,
    [MetodoPago] NVARCHAR(20) NOT NULL, -- 'Efectivo', 'Tarjeta', 'Telepeaje'
    [NumeroTicket] NVARCHAR(50) NULL,
    [OperadorID] NVARCHAR(50) NULL,
    [Estado] NVARCHAR(20) NOT NULL DEFAULT 'Completada', -- 'Completada', 'Cancelada', 'Pendiente'
    [Observaciones] NVARCHAR(500) NULL,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    
    CONSTRAINT [PK_Transacciones] PRIMARY KEY CLUSTERED ([TransaccionID]),
    CONSTRAINT [FK_Transacciones_Estaciones] FOREIGN KEY ([EstacionID]) 
        REFERENCES [peaje].[Estaciones]([EstacionID]),
    CONSTRAINT [FK_Transacciones_Carriles] FOREIGN KEY ([CarrilID]) 
        REFERENCES [peaje].[Carriles]([CarrilID]),
    CONSTRAINT [FK_Transacciones_TiposVehiculo] FOREIGN KEY ([TipoVehiculoID]) 
        REFERENCES [peaje].[TiposVehiculo]([TipoVehiculoID]),
    CONSTRAINT [CK_Transacciones_MetodoPago] CHECK ([MetodoPago] IN ('Efectivo', 'Tarjeta', 'Telepeaje')),
    CONSTRAINT [CK_Transacciones_Estado] CHECK ([Estado] IN ('Completada', 'Cancelada', 'Pendiente')),
    CONSTRAINT [CK_Transacciones_Montos] CHECK ([MontoTarifa] >= 0 AND [MontoPagado] >= 0)
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_Transacciones_FechaHora] ON [peaje].[Transacciones] ([FechaHora])
CREATE NONCLUSTERED INDEX [IX_Transacciones_EstacionID_FechaHora] 
    ON [peaje].[Transacciones] ([EstacionID], [FechaHora])
CREATE NONCLUSTERED INDEX [IX_Transacciones_Placa] ON [peaje].[Transacciones] ([Placa])
CREATE NONCLUSTERED INDEX [IX_Transacciones_NumeroTicket] ON [peaje].[Transacciones] ([NumeroTicket])
GO
