-- ============================================
-- Script: Despliegue Completo
-- Descripción: Script maestro para desplegar toda la base de datos
-- NOTA: Ejecutar cada sección paso a paso o usar SQLCMD con los archivos individuales
-- ============================================

PRINT '=== INICIANDO DESPLIEGUE SISTEMA DE PEAJE ==='
PRINT 'Fecha: ' + CONVERT(VARCHAR, GETDATE(), 120)
GO

PRINT 'INSTRUCCIONES DE DESPLIEGUE:'
PRINT '1. Ejecutar: Scripts\Deployment\01_CreateDatabase.sql'
PRINT '2. Ejecutar: Database\Schemas\01_CreateSchemas.sql'
PRINT '3. Ejecutar todos los archivos en Database\Tables\ en orden numérico'
PRINT '4. Ejecutar: Database\Functions\01_fn_ObtenerTarifaVigente.sql'
PRINT '5. Ejecutar: Database\StoredProcedures\01_sp_RegistrarTransaccion.sql'
PRINT '6. Ejecutar: Database\Views\01_vw_ResumenTransaccionesDiarias.sql'
PRINT '7. Ejecutar todos los archivos en Scripts\SeedData\ en orden numérico'
PRINT ''
PRINT 'Alternativamente, use el siguiente comando SQLCMD:'
PRINT 'sqlcmd -S [servidor] -d master -i "Scripts\Deployment\03_DeployBatch.bat"'
GO
