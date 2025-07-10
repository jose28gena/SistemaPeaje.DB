-- ============================================
-- Tabla: peaje.Empleados
-- Descripción: Datos laborales de empleados
-- Módulo: 5 - Empleados
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[Empleados] (
    [EmpleadoID] INT IDENTITY(1,1) NOT NULL,
    [NumeroEmpleado] NVARCHAR(20) NOT NULL,
    [Nombres] NVARCHAR(100) NOT NULL,
    [Apellidos] NVARCHAR(100) NOT NULL,
    [Email] NVARCHAR(100) NULL,
    [Telefono] NVARCHAR(20) NULL,
    [Puesto] NVARCHAR(100) NOT NULL,
    [Departamento] NVARCHAR(100) NULL,
    [EstacionAsignadaID] INT NULL,
    [FechaIngreso] DATE NOT NULL,
    [FechaBaja] DATE NULL,
    [Salario] DECIMAL(10,2) NULL,
    [Estado] NVARCHAR(20) NOT NULL DEFAULT 'Activo', -- 'Activo', 'Inactivo', 'Suspendido', 'Baja'
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    [FechaModificacion] DATETIME2(7) NULL,
    [UsuarioModificacion] NVARCHAR(50) NULL,
    
    CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED ([EmpleadoID]),
    CONSTRAINT [FK_Empleados_Estaciones] FOREIGN KEY ([EstacionAsignadaID]) 
        REFERENCES [peaje].[Estaciones]([EstacionID]),
    CONSTRAINT [UK_Empleados_NumeroEmpleado] UNIQUE ([NumeroEmpleado]),
    CONSTRAINT [CK_Empleados_Estado] CHECK ([Estado] IN ('Activo', 'Inactivo', 'Suspendido', 'Baja'))
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_Empleados_NumeroEmpleado] ON [peaje].[Empleados] ([NumeroEmpleado])
CREATE NONCLUSTERED INDEX [IX_Empleados_EstacionAsignada] ON [peaje].[Empleados] ([EstacionAsignadaID])
CREATE NONCLUSTERED INDEX [IX_Empleados_Estado] ON [peaje].[Empleados] ([Estado])
GO
