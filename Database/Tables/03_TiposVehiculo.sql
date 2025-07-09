-- ============================================
-- Tabla: peaje.TiposVehiculo
-- Descripción: Catálogo de tipos de vehículos
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[TiposVehiculo] (
    [TipoVehiculoID] INT IDENTITY(1,1) NOT NULL,
    [Codigo] NVARCHAR(10) NOT NULL,
    [Descripcion] NVARCHAR(100) NOT NULL,
    [NumeroEjes] INT NOT NULL,
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    
    CONSTRAINT [PK_TiposVehiculo] PRIMARY KEY CLUSTERED ([TipoVehiculoID]),
    CONSTRAINT [UK_TiposVehiculo_Codigo] UNIQUE ([Codigo])
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_TiposVehiculo_Activo] ON [peaje].[TiposVehiculo] ([Activo])
GO
