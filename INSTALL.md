# Guía de Instalación - Sistema de Peaje DB

## Requisitos Previos

- SQL Server 2019 o superior
- SQL Server Management Studio (SSMS) o Azure Data Studio
- Permisos de administrador en el servidor SQL Server

## Métodos de Instalación

### Método 1: Script Automático (Recomendado)

1. Abrir línea de comandos en la carpeta `Scripts\Deployment`
2. Ejecutar:
   ```batch
   deploy.bat [NOMBRE_SERVIDOR]
   ```
   Ejemplo:
   ```batch
   deploy.bat localhost
   deploy.bat MISERVIDOR\SQLEXPRESS
   ```

### Método 2: Manual paso a paso

1. **Crear Base de Datos**
   ```sql
   -- Ejecutar en SSMS conectado a master
   Scripts\Deployment\01_CreateDatabase.sql
   ```

2. **Crear Esquemas**
   ```sql
   -- Ejecutar en SSMS conectado a SistemaPeaje
   Database\Schemas\01_CreateSchemas.sql
   ```

3. **Crear Tablas** (ejecutar en orden)
   ```sql
   Database\Tables\01_Estaciones.sql
   Database\Tables\02_Carriles.sql
   Database\Tables\03_TiposVehiculo.sql
   Database\Tables\04_Tarifas.sql
   Database\Tables\05_Transacciones.sql
   Database\Tables\06_Usuarios.sql
   ```

4. **Crear Funciones**
   ```sql
   Database\Functions\01_fn_ObtenerTarifaVigente.sql
   ```

5. **Crear Procedimientos**
   ```sql
   Database\StoredProcedures\01_sp_RegistrarTransaccion.sql
   ```

6. **Crear Vistas**
   ```sql
   Database\Views\01_vw_ResumenTransaccionesDiarias.sql
   ```

7. **Insertar Datos Iniciales** (ejecutar en orden)
   ```sql
   Scripts\SeedData\01_TiposVehiculo.sql
   Scripts\SeedData\02_Estaciones.sql
   Scripts\SeedData\03_Tarifas.sql
   ```

## Verificación de la Instalación

Ejecutar las siguientes consultas para verificar que todo se instaló correctamente:

```sql
-- Verificar esquemas
SELECT name FROM sys.schemas WHERE name IN ('peaje', 'seguridad', 'auditoria', 'configuracion')

-- Verificar tablas
SELECT 
    s.name AS Esquema,
    t.name AS Tabla,
    COUNT(c.column_id) AS NumColumnas
FROM sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    INNER JOIN sys.columns c ON t.object_id = c.object_id
WHERE s.name IN ('peaje', 'seguridad')
GROUP BY s.name, t.name
ORDER BY s.name, t.name

-- Verificar datos iniciales
SELECT 'TiposVehiculo' AS Tabla, COUNT(*) AS Registros FROM peaje.TiposVehiculo
UNION ALL
SELECT 'Estaciones', COUNT(*) FROM peaje.Estaciones
UNION ALL
SELECT 'Carriles', COUNT(*) FROM peaje.Carriles
UNION ALL
SELECT 'Tarifas', COUNT(*) FROM peaje.Tarifas
```

## Configuración Posterior

1. **Crear usuario de aplicación**
2. **Configurar permisos**
3. **Configurar backup automático**
4. **Revisar configuración de memoria y performance**

## Solución de Problemas

### Error: Base de datos ya existe
- Eliminar la base de datos existente o cambiar el nombre en el script

### Error: Permisos insuficientes
- Ejecutar como administrador de SQL Server
- Verificar permisos en la carpeta de datos

### Error: Rutas de archivos
- Modificar las rutas en `01_CreateDatabase.sql` según su configuración

## Contacto

Para soporte técnico, revisar la documentación en `Documentation\DatabaseDocumentation.md`
