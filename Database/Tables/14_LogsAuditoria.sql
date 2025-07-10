-- ============================================
-- Tabla: auditoria.LogsAuditoria
-- Descripción: Registro central de auditoría
-- Módulo: 16 - Seguridad, Logs & Control
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [auditoria].[LogsAuditoria] (
    [LogID] BIGINT IDENTITY(1,1) NOT NULL,
    [TipoOperacion] NVARCHAR(50) NOT NULL, -- 'INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT'
    [TablaAfectada] NVARCHAR(100) NULL,
    [RegistroID] NVARCHAR(50) NULL,
    [UsuarioID] NVARCHAR(50) NOT NULL,
    [DireccionIP] NVARCHAR(45) NULL,
    [Aplicacion] NVARCHAR(100) NULL,
    [ValoresAnteriores] NVARCHAR(MAX) NULL, -- JSON
    [ValoresNuevos] NVARCHAR(MAX) NULL,     -- JSON
    [Descripcion] NVARCHAR(500) NULL,
    [FechaHora] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [Exitoso] BIT NOT NULL DEFAULT 1,
    [MensajeError] NVARCHAR(500) NULL,
    
    CONSTRAINT [PK_LogsAuditoria] PRIMARY KEY CLUSTERED ([LogID])
)
GO

-- Índices para consultas de auditoría
CREATE NONCLUSTERED INDEX [IX_LogsAuditoria_FechaHora] ON [auditoria].[LogsAuditoria] ([FechaHora] DESC)
CREATE NONCLUSTERED INDEX [IX_LogsAuditoria_UsuarioID] ON [auditoria].[LogsAuditoria] ([UsuarioID], [FechaHora] DESC)
CREATE NONCLUSTERED INDEX [IX_LogsAuditoria_TablaOperacion] ON [auditoria].[LogsAuditoria] ([TablaAfectada], [TipoOperacion], [FechaHora] DESC)
GO
