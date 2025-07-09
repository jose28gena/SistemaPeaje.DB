-- ============================================
-- Tabla: peaje.Carriles
-- Descripción: Carriles de cada estación de peaje
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[Carriles] (
    [CarrilID] INT IDENTITY(1,1) NOT NULL,
    [EstacionID] INT NOT NULL,
    [NumeroCarril] INT NOT NULL,
    [TipoCarril] NVARCHAR(20) NOT NULL, -- 'Manual', 'Automatico', 'Telepeaje'
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    [FechaModificacion] DATETIME2(7) NULL,
    [UsuarioModificacion] NVARCHAR(50) NULL,
    
    CONSTRAINT [PK_Carriles] PRIMARY KEY CLUSTERED ([CarrilID]),
    CONSTRAINT [FK_Carriles_Estaciones] FOREIGN KEY ([EstacionID]) 
        REFERENCES [peaje].[Estaciones]([EstacionID]),
    CONSTRAINT [UK_Carriles_Estacion_Numero] UNIQUE ([EstacionID], [NumeroCarril]),
    CONSTRAINT [CK_Carriles_TipoCarril] CHECK ([TipoCarril] IN ('Manual', 'Automatico', 'Telepeaje'))
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_Carriles_EstacionID] ON [peaje].[Carriles] ([EstacionID])
CREATE NONCLUSTERED INDEX [IX_Carriles_TipoCarril] ON [peaje].[Carriles] ([TipoCarril])
GO
