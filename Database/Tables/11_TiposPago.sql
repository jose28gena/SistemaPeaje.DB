-- ============================================
-- Tabla: peaje.TiposPago
-- Descripción: Métodos de pago disponibles
-- Módulo: 10 - Tipos de Pago
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[TiposPago] (
    [TipoPagoID] INT IDENTITY(1,1) NOT NULL,
    [Codigo] NVARCHAR(20) NOT NULL,
    [Descripcion] NVARCHAR(100) NOT NULL,
    [RequiereTarjeta] BIT NOT NULL DEFAULT 0,
    [PermiteCredito] BIT NOT NULL DEFAULT 0,
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    
    CONSTRAINT [PK_TiposPago] PRIMARY KEY CLUSTERED ([TipoPagoID]),
    CONSTRAINT [UK_TiposPago_Codigo] UNIQUE ([Codigo])
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_TiposPago_Codigo] ON [peaje].[TiposPago] ([Codigo])
GO
