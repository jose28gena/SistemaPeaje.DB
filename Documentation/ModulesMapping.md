# Mapeo de Módulos - Sistema de Peaje

## Resumen de Implementación

La base de datos ha sido expandida para cubrir los 17 módulos identificados del sistema de peaje. A continuación se detalla el mapeo entre módulos, tablas de BD y servicios API sugeridos.

## Módulos Implementados

### 1. Clientes & Facturación
**Propósito**: Alta de clientes, RFC, razón social, emisión CFDI
**Tablas BD**: 
- `peaje.Clientes`

**Servicios API**: 
- `ClientService`
- `BillingService`

**Campos Clave**: RFC, RazonSocial, TipoCliente, DatosFiscales

---

### 2. Tarjetas (RFID)
**Propósito**: Registro, asignación, bloqueo y reemplazo de TAG
**Tablas BD**: 
- `peaje.TarjetasRFID`

**Servicios API**: 
- `RFIDCardService`

**Campos Clave**: NumeroTarjeta, Estado, SaldoActual, TipoTarjeta

---

### 3. Casetas (Booths)
**Propósito**: Catálogo de casetas físicas
**Tablas BD**: 
- `peaje.Estaciones` (ya existente)

**Servicios API**: 
- `BoothService`

**Campos Clave**: Codigo, Nombre, Ubicacion, Kilometro

---

### 4. Carriles (Lanes)
**Propósito**: Configuración de carriles, sensores, estatus
**Tablas BD**: 
- `peaje.Carriles` (ya existente)

**Servicios API**: 
- `LaneService`
- `TerminalService`

**Campos Clave**: NumeroCarril, TipoCarril, Estado

---

### 5. Empleados
**Propósito**: Datos laborales, asignaciones
**Tablas BD**: 
- `peaje.Empleados`

**Servicios API**: 
- `EmployeeService`

**Campos Clave**: NumeroEmpleado, Puesto, EstacionAsignada

---

### 6. Usuarios
**Propósito**: Cuentas de acceso (operador + admin)
**Tablas BD**: 
- `seguridad.Usuarios` (ya existente)

**Servicios API**: 
- `UserService`
- `RoleService`

**Campos Clave**: NombreUsuario, Email, Activo

---

### 7. Tarifas (8 conceptos)
**Propósito**: Administración de tablas de tarifas y vigencias
**Tablas BD**: 
- `peaje.Tarifas` (ya existente)

**Servicios API**: 
- `TariffService`

**Campos Clave**: Monto, FechaVigencia, TipoVehiculo

---

### 8. Clases Vehiculares
**Propósito**: AUTO, 2EJ, 3EJ...
**Tablas BD**: 
- `peaje.ClasesVehiculares`

**Servicios API**: 
- `VehicleClassService`

**Campos Clave**: Codigo, NumeroEjes, PesoMaximo

---

### 9. Tipos de Vehículos
**Propósito**: Sedan, SUV, Bus, Camión...
**Tablas BD**: 
- `peaje.TiposVehiculo` (ya existente, actualizada)

**Servicios API**: 
- `VehicleTypeService`

**Campos Clave**: Codigo, Descripcion, ClaseVehicular

---

### 10. Tipos de Pago
**Propósito**: Efectivo, Prepago, Residente
**Tablas BD**: 
- `peaje.TiposPago`

**Servicios API**: 
- `PaymentTypeService`

**Campos Clave**: Codigo, RequiereTarjeta, PermiteCredito

---

### 11. Reportes
**Propósito**: KPI de operación, aforo e ingresos
**Tablas BD**: 
- Vistas: `peaje.vw_ResumenTransaccionesDiarias`
- Datos de: `peaje.Transacciones`, `peaje.EventosTransito`

**Servicios API**: 
- `ReportService`
- `IndicatorService`

---

### 12. Turnos
**Propósito**: Apertura, cierre y control de turno
**Tablas BD**: 
- `peaje.Turnos`

**Servicios API**: 
- `ShiftService`
- `ReconciliationService`

**Procedimientos**: `sp_AbrirTurno`, `sp_CerrarTurno`

---

### 13. Monitor de Eventos
**Propósito**: Streaming y log de eventos en tiempo real
**Tablas BD**: 
- `peaje.EventosTransito`

**Servicios API**: 
- `EventMonitorService` (WebSocket)

**Procedimientos**: `sp_RegistrarEventoTransito`

---

### 14. Pre-liquidación
**Propósito**: Cortes de caja (cajero, turno, día)
**Tablas BD**: 
- `peaje.Turnos`
- `peaje.Transacciones`

**Servicios API**: 
- `ReconciliationService`

---

### 15. Validación Evento vs Cobro
**Propósito**: Auditoría automática con evidencia visual
**Tablas BD**: 
- `peaje.EventosTransito`
- `peaje.Transacciones`
- Relación: `EventoOrigenID`

**Servicios API**: 
- `AuditService`
- `ValidationService`

---

### 16. Seguridad, Logs & Control
**Propósito**: Autenticación, autorización, logging central
**Tablas BD**: 
- `auditoria.LogsAuditoria`
- `seguridad.Usuarios`

**Servicios API**: 
- `AuthService`
- `AuditService`
- `LogService`

---

### 17. Integración Cámaras
**Propósito**: Captura OCR/LPR e imágenes de Hikvision
**Tablas BD**: 
- `peaje.EventosTransito` (campo ImagenRuta)
- `peaje.Transacciones` (campo ImagenComprobante)

**Servicios API**: 
- `CameraIntegrationService`

---

## Estadísticas de Implementación

- ✅ **Tablas Creadas**: 15 tablas principales
- ✅ **Esquemas**: 4 esquemas organizados
- ✅ **Procedimientos**: 3 procedimientos almacenados
- ✅ **Funciones**: 1 función personalizada
- ✅ **Vistas**: 1 vista de resumen
- ✅ **Datos Iniciales**: 5 scripts de seed data

## Próximos Pasos Sugeridos

1. **Implementar Triggers de Auditoría**: Para registro automático en `auditoria.LogsAuditoria`
2. **Crear Vistas Adicionales**: Para reportes y KPIs específicos
3. **Desarrollar APIs REST**: Basadas en el mapeo de servicios
4. **Implementar WebSockets**: Para monitor de eventos en tiempo real
5. **Configurar Índices de Performance**: Para consultas de alto volumen
