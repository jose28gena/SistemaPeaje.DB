-- ============================================
-- Tabla: seguridad.Usuarios
-- Descripción: Usuarios del sistema
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [seguridad].[Usuarios] (
    [UsuarioID] INT IDENTITY(1,1) NOT NULL,
    [NombreUsuario] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) NOT NULL,
    [Nombres] NVARCHAR(100) NOT NULL,
    [Apellidos] NVARCHAR(100) NOT NULL,
    [PasswordHash] NVARCHAR(255) NOT NULL,
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaUltimoAcceso] DATETIME2(7) NULL,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    [FechaModificacion] DATETIME2(7) NULL,
    [UsuarioModificacion] NVARCHAR(50) NULL,
    
    CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED ([UsuarioID]),
    CONSTRAINT [UK_Usuarios_NombreUsuario] UNIQUE ([NombreUsuario]),
    CONSTRAINT [UK_Usuarios_Email] UNIQUE ([Email])
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_Usuarios_Activo] ON [seguridad].[Usuarios] ([Activo])
GO
