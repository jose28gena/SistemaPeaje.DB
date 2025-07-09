-- ============================================
-- Script: Crear Base de Datos Sistema de Peaje
-- Descripción: Script principal para crear la base de datos
-- Autor: Sistema de Peaje DB
-- Fecha: 2025-07-09
-- ============================================

-- Verificar si la base de datos existe
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'SistemaPeaje')
BEGIN
    CREATE DATABASE [SistemaPeaje]
    ON 
    ( NAME = 'SistemaPeaje_Data',
      FILENAME = 'C:\Data\SistemaPeaje_Data.mdf',
      SIZE = 100MB,
      MAXSIZE = 1GB,
      FILEGROWTH = 10MB )
    LOG ON 
    ( NAME = 'SistemaPeaje_Log',
      FILENAME = 'C:\Data\SistemaPeaje_Log.ldf',
      SIZE = 10MB,
      MAXSIZE = 100MB,
      FILEGROWTH = 5MB );
      
    PRINT 'Base de datos SistemaPeaje creada exitosamente'
END
ELSE
BEGIN
    PRINT 'La base de datos SistemaPeaje ya existe'
END

-- Usar la base de datos
USE [SistemaPeaje]
GO

-- Configurar opciones de la base de datos
ALTER DATABASE [SistemaPeaje] SET RECOVERY FULL
ALTER DATABASE [SistemaPeaje] SET AUTO_SHRINK OFF
ALTER DATABASE [SistemaPeaje] SET AUTO_CREATE_STATISTICS ON
ALTER DATABASE [SistemaPeaje] SET AUTO_UPDATE_STATISTICS ON

PRINT 'Configuración de base de datos completada'
