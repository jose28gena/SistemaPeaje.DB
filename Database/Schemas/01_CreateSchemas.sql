-- ============================================
-- Script: Crear Esquemas
-- Descripción: Crear los esquemas principales del sistema
-- ============================================

USE [SistemaPeaje]
GO

-- Esquema para el sistema de peaje
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'peaje')
BEGIN
    EXEC('CREATE SCHEMA [peaje]')
    PRINT 'Esquema [peaje] creado'
END

-- Esquema para seguridad
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'seguridad')
BEGIN
    EXEC('CREATE SCHEMA [seguridad]')
    PRINT 'Esquema [seguridad] creado'
END

-- Esquema para auditoría
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'auditoria')
BEGIN
    EXEC('CREATE SCHEMA [auditoria]')
    PRINT 'Esquema [auditoria] creado'
END

-- Esquema para configuración
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'configuracion')
BEGIN
    EXEC('CREATE SCHEMA [configuracion]')
    PRINT 'Esquema [configuracion] creado'
END
