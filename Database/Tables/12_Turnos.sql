-- ============================================
-- Tabla: peaje.Turnos
-- Descripción: Control de turnos de trabajo
-- Módulo: 12 - Turnos
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[Turnos] (
    [TurnoID] INT IDENTITY(1,1) NOT NULL,
    [NumeroTurno] NVARCHAR(20) NOT NULL,
    [EmpleadoID] INT NOT NULL,
    [EstacionID] INT NOT NULL,
    [CarrilID] INT NULL,
    [FechaInicio] DATETIME2(7) NOT NULL,
    [FechaFin] DATETIME2(7) NULL,
    [MontoInicialEfectivo] DECIMAL(10,2) NOT NULL DEFAULT 0,
    [MontoFinalEfectivo] DECIMAL(10,2) NULL,
    [TotalTransacciones] INT NULL,
    [TotalIngresos] DECIMAL(10,2) NULL,
    [Estado] NVARCHAR(20) NOT NULL DEFAULT 'Abierto', -- 'Abierto', 'Cerrado', 'Cancelado'
    [Observaciones] NVARCHAR(500) NULL,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    [FechaCierre] DATETIME2(7) NULL,
    [UsuarioCierre] NVARCHAR(50) NULL,
    
    CONSTRAINT [PK_Turnos] PRIMARY KEY CLUSTERED ([TurnoID]),
    CONSTRAINT [FK_Turnos_Empleados] FOREIGN KEY ([EmpleadoID]) 
        REFERENCES [peaje].[Empleados]([EmpleadoID]),
    CONSTRAINT [FK_Turnos_Estaciones] FOREIGN KEY ([EstacionID]) 
        REFERENCES [peaje].[Estaciones]([EstacionID]),
    CONSTRAINT [FK_Turnos_Carriles] FOREIGN KEY ([CarrilID]) 
        REFERENCES [peaje].[Carriles]([CarrilID]),
    CONSTRAINT [UK_Turnos_Numero] UNIQUE ([NumeroTurno]),
    CONSTRAINT [CK_Turnos_Estado] CHECK ([Estado] IN ('Abierto', 'Cerrado', 'Cancelado'))
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_Turnos_EmpleadoID_FechaInicio] ON [peaje].[Turnos] ([EmpleadoID], [FechaInicio])
CREATE NONCLUSTERED INDEX [IX_Turnos_EstacionID_FechaInicio] ON [peaje].[Turnos] ([EstacionID], [FechaInicio])
CREATE NONCLUSTERED INDEX [IX_Turnos_Estado] ON [peaje].[Turnos] ([Estado])
GO
