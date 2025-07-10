@echo off
echo ================================================
echo  VERIFICANDO CONEXION A SQL SERVER
echo ================================================
echo.

set SERVER_NAME=%1

if "%SERVER_NAME%"=="" (
    echo Error: Debe especificar el nombre del servidor
    echo Uso: test-connection.bat [SERVIDOR]
    echo Ejemplo: test-connection.bat DESKTOP-N7I472Q
    goto :end
)

echo Probando conexión a: %SERVER_NAME%
echo.

echo Ejecutando consulta de prueba...
sqlcmd -S %SERVER_NAME% -E -Q "SELECT @@VERSION AS [SQL Server Version], GETDATE() AS [Current Date]"

if %errorlevel% equ 0 (
    echo.
    echo ================================================
    echo  CONEXION EXITOSA
    echo ================================================
    echo Ya puede ejecutar: deploy.bat %SERVER_NAME%
) else (
    echo.
    echo ================================================
    echo  ERROR DE CONEXION
    echo ================================================
    echo Verifique que:
    echo 1. SQL Server esté ejecutándose
    echo 2. El nombre del servidor sea correcto
    echo 3. Tenga permisos de administrador
)

:end
pause
