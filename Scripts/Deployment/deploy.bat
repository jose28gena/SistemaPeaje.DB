@echo off
echo ===============================================
echo  SISTEMA DE PEAJE - DESPLIEGUE AUTOMATICO
echo ===============================================
echo.

REM Configurar variables
set SERVER_NAME=%1
set DATABASE_NAME=SistemaPeaje
set SCRIPT_DIR=%~dp0

if "%SERVER_NAME%"=="" (
    echo Error: Debe especificar el nombre del servidor
    echo Uso: deploy.bat [SERVIDOR]
    echo Ejemplo: deploy.bat localhost
    echo Ejemplo: deploy.bat DESKTOP-N7I472Q
    goto :end
)

echo Servidor: %SERVER_NAME%
echo Base de datos: %DATABASE_NAME%
echo Directorio base: %SCRIPT_DIR%
echo.

echo 1. Creando base de datos...
sqlcmd -S %SERVER_NAME% -E -i "%SCRIPT_DIR%01_CreateDatabase.sql"
if %errorlevel% neq 0 goto :error

echo 2. Creando esquemas...
sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Schemas\01_CreateSchemas.sql"
if %errorlevel% neq 0 goto :error

echo 3. Creando tablas...
sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Tables\01_Estaciones.sql"
if %errorlevel% neq 0 goto :error

sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Tables\02_Carriles.sql"
if %errorlevel% neq 0 goto :error

sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Tables\03_TiposVehiculo.sql"
if %errorlevel% neq 0 goto :error

sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Tables\04_Tarifas.sql"
if %errorlevel% neq 0 goto :error

sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Tables\05_Transacciones.sql"
if %errorlevel% neq 0 goto :error

sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Tables\06_Usuarios.sql"
if %errorlevel% neq 0 goto :error

echo 4. Creando funciones...
sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Functions\01_fn_ObtenerTarifaVigente.sql"
if %errorlevel% neq 0 goto :error

echo 5. Creando procedimientos almacenados...
sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\StoredProcedures\01_sp_RegistrarTransaccion.sql"
if %errorlevel% neq 0 goto :error

echo 6. Creando vistas...
sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\..\Database\Views\01_vw_ResumenTransaccionesDiarias.sql"
if %errorlevel% neq 0 goto :error

echo 7. Insertando datos iniciales...
sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\SeedData\01_TiposVehiculo.sql"
if %errorlevel% neq 0 goto :error

sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\SeedData\02_Estaciones.sql"
if %errorlevel% neq 0 goto :error

sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -E -i "%SCRIPT_DIR%..\SeedData\03_Tarifas.sql"
if %errorlevel% neq 0 goto :error

echo.
echo ===============================================
echo  DESPLIEGUE COMPLETADO EXITOSAMENTE
echo ===============================================
echo Base de datos %DATABASE_NAME% lista para usar
goto :end

:error
echo.
echo ===============================================
echo  ERROR EN EL DESPLIEGUE
echo ===============================================
echo Revise los mensajes de error anteriores

:end
pause
