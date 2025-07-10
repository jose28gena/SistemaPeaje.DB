-- ============================================
-- Tabla: peaje.ClasesVehiculares
-- Descripción: Clasificación vehicular (AUTO, 2EJ, 3EJ, etc.)
-- Módulo: 8 - Clases Vehiculares
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[ClasesVehiculares] (
    [ClaseVehicularID] INT IDENTITY(1,1) NOT NULL,
    [Codigo] NVARCHAR(10) NOT NULL,
    [Descripcion] NVARCHAR(100) NOT NULL,
    [NumeroEjes] INT NOT NULL,
    [PesoMaximo] DECIMAL(10,2) NULL, -- En toneladas
    [AltoMaximo] DECIMAL(5,2) NULL,  -- En metros
    [Observaciones] NVARCHAR(500) NULL,
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    
    CONSTRAINT [PK_ClasesVehiculares] PRIMARY KEY CLUSTERED ([ClaseVehicularID]),
    CONSTRAINT [UK_ClasesVehiculares_Codigo] UNIQUE ([Codigo])
)
GO

-- Actualizar tabla TiposVehiculo para referenciar ClasesVehiculares
ALTER TABLE [peaje].[TiposVehiculo] 
ADD [ClaseVehicularID] INT NULL;

ALTER TABLE [peaje].[TiposVehiculo] 
ADD CONSTRAINT [FK_TiposVehiculo_ClasesVehiculares] 
FOREIGN KEY ([ClaseVehicularID]) REFERENCES [peaje].[ClasesVehiculares]([ClaseVehicularID]);

-- Índices
CREATE NONCLUSTERED INDEX [IX_ClasesVehiculares_Codigo] ON [peaje].[ClasesVehiculares] ([Codigo])
CREATE NONCLUSTERED INDEX [IX_ClasesVehiculares_NumeroEjes] ON [peaje].[ClasesVehiculares] ([NumeroEjes])
GO
