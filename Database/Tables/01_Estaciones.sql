-- ============================================
-- Tabla: peaje.Estaciones
-- Descripción: Catálogo de estaciones de peaje
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[Estaciones] (
    [EstacionID] INT IDENTITY(1,1) NOT NULL,
    [Codigo] NVARCHAR(20) NOT NULL,
    [Nombre] NVARCHAR(100) NOT NULL,
    [Ubicacion] NVARCHAR(200) NULL,
    [Kilometro] DECIMAL(10,2) NULL,
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    [FechaModificacion] DATETIME2(7) NULL,
    [UsuarioModificacion] NVARCHAR(50) NULL,
    
    CONSTRAINT [PK_Estaciones] PRIMARY KEY CLUSTERED ([EstacionID]),
    CONSTRAINT [UK_Estaciones_Codigo] UNIQUE ([Codigo])
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_Estaciones_Nombre] ON [peaje].[Estaciones] ([Nombre])
CREATE NONCLUSTERED INDEX [IX_Estaciones_Activo] ON [peaje].[Estaciones] ([Activo])
GO
