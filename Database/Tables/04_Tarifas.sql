-- ============================================
-- Tabla: peaje.Tarifas
-- Descripción: Tarifas por estación y tipo de vehículo
-- ============================================

USE [SistemaPeaje]
GO

CREATE TABLE [peaje].[Tarifas] (
    [TarifaID] INT IDENTITY(1,1) NOT NULL,
    [EstacionID] INT NOT NULL,
    [TipoVehiculoID] INT NOT NULL,
    [Monto] DECIMAL(10,2) NOT NULL,
    [FechaVigenciaInicio] DATE NOT NULL,
    [FechaVigenciaFin] DATE NULL,
    [Activo] BIT NOT NULL DEFAULT 1,
    [FechaCreacion] DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    [UsuarioCreacion] NVARCHAR(50) NOT NULL,
    
    CONSTRAINT [PK_Tarifas] PRIMARY KEY CLUSTERED ([TarifaID]),
    CONSTRAINT [FK_Tarifas_Estaciones] FOREIGN KEY ([EstacionID]) 
        REFERENCES [peaje].[Estaciones]([EstacionID]),
    CONSTRAINT [FK_Tarifas_TiposVehiculo] FOREIGN KEY ([TipoVehiculoID]) 
        REFERENCES [peaje].[TiposVehiculo]([TipoVehiculoID]),
    CONSTRAINT [CK_Tarifas_Monto] CHECK ([Monto] >= 0),
    CONSTRAINT [CK_Tarifas_Fechas] CHECK ([FechaVigenciaFin] IS NULL OR [FechaVigenciaFin] >= [FechaVigenciaInicio])
)
GO

-- Índices
CREATE NONCLUSTERED INDEX [IX_Tarifas_EstacionID_TipoVehiculo] 
    ON [peaje].[Tarifas] ([EstacionID], [TipoVehiculoID])
CREATE NONCLUSTERED INDEX [IX_Tarifas_FechaVigencia] 
    ON [peaje].[Tarifas] ([FechaVigenciaInicio], [FechaVigenciaFin])
GO
