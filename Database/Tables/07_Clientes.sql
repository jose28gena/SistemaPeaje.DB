-- ============================================
-- Tabla: peaje.Clientes
-- Descripción: Información de clientes para facturación
-- Módulo: 1 - Clientes & Facturación
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[Clientes] (
    [ClienteID] INT IDENTITY(1,1) NOT NULL,
    [RFC] NVARCHAR(20) NOT NULL,
    [RazonSocial] NVARCHAR(200) NOT NULL,
    [NombreComercial] NVARCHAR(200) NULL,
    [Email] NVARCHAR(100) NULL,
    [Telefono] NVARCHAR(20) NULL,
    [Direccion] NVARCHAR(500) NULL,
    [CodigoPostal] NVARCHAR(10) NULL,
    [Ciudad] NVARCHAR(100) NULL,
    [Estado] NVARCHAR(100) NULL,
    [Pais] NVARCHAR(100) NULL DEFAULT 'México',
    [TipoCliente] NVARCHAR(20) NOT NULL DEFAULT 'Individual', -- 'Individual', 'Corporativo', 'Gobierno'
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaRegistro] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    [FechaModificacion] DATETIME2(7) NULL,
    [UsuarioModificacion] NVARCHAR(50) NULL,
    
    CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED ([ClienteID]),
    CONSTRAINT [UK_Clientes_RFC] UNIQUE ([RFC]),
    CONSTRAINT [CK_Clientes_TipoCliente] CHECK ([TipoCliente] IN ('Individual', 'Corporativo', 'Gobierno'))
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_Clientes_RFC] ON [peaje].[Clientes] ([RFC])
CREATE NONCLUSTERED INDEX [IX_Clientes_RazonSocial] ON [peaje].[Clientes] ([RazonSocial])
CREATE NONCLUSTERED INDEX [IX_Clientes_TipoCliente] ON [peaje].[Clientes] ([TipoCliente])
GO
