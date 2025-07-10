-- ============================================
-- Script: Crear Base de Datos Sistema de Peaje
-- Descripción: Script principal para crear la base de datos
-- Autor: Sistema de Peaje DB
-- Fecha: 2025-07-09
-- ============================================

-- Verificar si la base de datos existe
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'SistemaPeaje')
BEGIN
    -- Crear base de datos con configuración automática
    CREATE DATABASE [SistemaPeaje];
    PRINT 'Base de datos SistemaPeaje creada exitosamente'
END
ELSE
BEGIN
    PRINT 'La base de datos SistemaPeaje ya existe'
END
GO

-- Configurar opciones de la base de datos desde master
ALTER DATABASE [SistemaPeaje] SET RECOVERY SIMPLE
GO
ALTER DATABASE [SistemaPeaje] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [SistemaPeaje] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [SistemaPeaje] SET AUTO_UPDATE_STATISTICS ON
GO

PRINT 'Configuración de base de datos completada'
