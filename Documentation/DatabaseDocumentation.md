# Documentación del Sistema de Base de Datos - Sistema de Peaje

## Descripción General

El Sistema de Peaje es una base de datos diseñada para gestionar las operaciones de cobro de peaje en autopistas, incluyendo el registro de transacciones, gestión de estaciones, carriles, tarifas y usuarios.

## Arquitectura de la Base de Datos

### Esquemas

1. **peaje**: Contiene las tablas principales del sistema de peaje
2. **seguridad**: Gestión de usuarios y permisos
3. **auditoria**: Registro de auditoría y logs del sistema
4. **configuracion**: Parámetros de configuración del sistema

### Tablas Principales

#### peaje.Estaciones
- **Propósito**: Catálogo de estaciones de peaje
- **Campos principales**: EstacionID, Codigo, Nombre, Ubicacion, Kilometro
- **Relaciones**: Una estación puede tener múltiples carriles

#### peaje.Carriles
- **Propósito**: Carriles de cada estación
- **Campos principales**: CarrilID, EstacionID, NumeroCarril, TipoCarril
- **Tipos de carril**: Manual, Automatico, Telepeaje

#### peaje.TiposVehiculo
- **Propósito**: Categorización de vehículos para tarifas
- **Campos principales**: TipoVehiculoID, Codigo, Descripcion, NumeroEjes
- **Categorías**: CAT1 a CAT6 según número de ejes

#### peaje.Tarifas
- **Propósito**: Definición de tarifas por estación y tipo de vehículo
- **Campos principales**: TarifaID, EstacionID, TipoVehiculoID, Monto
- **Vigencia**: Controla fechas de inicio y fin de vigencia

#### peaje.Transacciones
- **Propósito**: Registro de todas las transacciones de peaje
- **Campos principales**: TransaccionID, EstacionID, CarrilID, FechaHora, MontoTarifa
- **Métodos de pago**: Efectivo, Tarjeta, Telepeaje

### Vistas

#### peaje.vw_ResumenTransaccionesDiarias
- Resumen diario de transacciones por estación y tipo de vehículo
- Incluye totales, promedios y cantidades

### Procedimientos Almacenados

#### peaje.sp_RegistrarTransaccion
- Registra una nueva transacción de peaje
- Calcula automáticamente la tarifa vigente
- Genera número de ticket único
- Maneja transacciones para integridad de datos

### Funciones

#### peaje.fn_ObtenerTarifaVigente
- Obtiene la tarifa vigente para una estación y tipo de vehículo
- Permite especificar fecha para consultas históricas

## Índices y Optimización

- Índices en campos de búsqueda frecuente (fechas, códigos, estados)
- Índices compuestos para consultas complejas
- Restricciones de integridad referencial

## Seguridad

- Esquema separado para gestión de usuarios
- Campos de auditoría en todas las tablas principales
- Control de acceso por roles y permisos

## Mantenimiento

- Campos de auditoría estándar (FechaCreacion, UsuarioCreacion, etc.)
- Soft delete con campo Activo
- Versionado de tarifas con fechas de vigencia
