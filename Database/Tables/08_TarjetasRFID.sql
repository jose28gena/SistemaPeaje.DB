-- ============================================
-- Tabla: peaje.TarjetasRFID
-- Descripción: Gestión de tarjetas RFID/TAG
-- Módulo: 2 - Tarjetas (RFID)
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[TarjetasRFID] (
    [TarjetaID] INT IDENTITY(1,1) NOT NULL,
    [NumeroTarjeta] NVARCHAR(50) NOT NULL,
    [ClienteID] INT NULL,
    [TipoTarjeta] NVARCHAR(20) NOT NULL DEFAULT 'Prepago', -- 'Prepago', 'Residente', 'Corporativa'
    [SaldoActual] DECIMAL(10,2) NOT NULL DEFAULT 0,
    [FechaVencimiento] DATE NULL,
    [Estado] NVARCHAR(20) NOT NULL DEFAULT 'Activa', -- 'Activa', 'Bloqueada', 'Suspendida', 'Cancelada'
    [MotivoBloqueo] NVARCHAR(200) NULL,
    [FechaActivacion] DATETIME2(7) NULL,
    [FechaBloqueo] DATETIME2(7) NULL,
    [TarjetaReemplazoID] INT NULL, -- Referencia a tarjeta de reemplazo
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    [FechaModificacion] DATETIME2(7) NULL,
    [UsuarioModificacion] NVARCHAR(50) NULL,
    
    CONSTRAINT [PK_TarjetasRFID] PRIMARY KEY CLUSTERED ([TarjetaID]),
    CONSTRAINT [FK_TarjetasRFID_Clientes] FOREIGN KEY ([ClienteID]) 
        REFERENCES [peaje].[Clientes]([ClienteID]),
    CONSTRAINT [FK_TarjetasRFID_Reemplazo] FOREIGN KEY ([TarjetaReemplazoID]) 
        REFERENCES [peaje].[TarjetasRFID]([TarjetaID]),
    CONSTRAINT [UK_TarjetasRFID_Numero] UNIQUE ([NumeroTarjeta]),
    CONSTRAINT [CK_TarjetasRFID_TipoTarjeta] CHECK ([TipoTarjeta] IN ('Prepago', 'Residente', 'Corporativa')),
    CONSTRAINT [CK_TarjetasRFID_Estado] CHECK ([Estado] IN ('Activa', 'Bloqueada', 'Suspendida', 'Cancelada')),
    CONSTRAINT [CK_TarjetasRFID_Saldo] CHECK ([SaldoActual] >= 0)
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_TarjetasRFID_NumeroTarjeta] ON [peaje].[TarjetasRFID] ([NumeroTarjeta])
CREATE NONCLUSTERED INDEX [IX_TarjetasRFID_ClienteID] ON [peaje].[TarjetasRFID] ([ClienteID])
CREATE NONCLUSTERED INDEX [IX_TarjetasRFID_Estado] ON [peaje].[TarjetasRFID] ([Estado])
GO
