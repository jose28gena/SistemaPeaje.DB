-- ============================================
-- Script: Datos Adicionales - Usuarios y Transacciones
-- Descripción: Completar datos faltantes
-- ============================================

USE [SistemaPeaje]
GO

-- Insertar usuarios del sistema
INSERT INTO [seguridad].[Usuarios] (
    NombreUsuario, Email, Nombres, Apellidos, PasswordHash, UsuarioCreacion
)
VALUES 
    ('admin', 'admin@peaje.com', 'Administrador', 'Sistema', 
     'AQAAAAEAACcQAAAAEGY8QmQyNJ5X7R+0zQzL5Q==', 'SYSTEM'), -- password: admin123
    ('operador1', 'jperez@peaje.com', 'Juan Carlos', 'Pérez García', 
     'AQAAAAEAACcQAAAAEGY8QmQyNJ5X7R+0zQzL5Q==', 'SYSTEM'), -- password: op123
    ('operador2', 'mgonzalez@peaje.com', 'María Elena', 'González López', 
     'AQAAAAEAACcQAAAAEGY8QmQyNJ5X7R+0zQzL5Q==', 'SYSTEM'), -- password: op123
    ('supervisor1', 'crodriguez@peaje.com', 'Carlos Alberto', 'Rodríguez Martín', 
     'AQAAAAEAACcQAAAAEGY8QmQyNJ5X7R+0zQzL5Q==', 'SYSTEM'); -- password: sup123

PRINT 'Usuarios insertados correctamente';

-- Insertar algunas transacciones de ejemplo
DECLARE @TransaccionID BIGINT;

-- Transacción 1: Vehículo categoría 1 con efectivo
EXEC peaje.sp_RegistrarTransaccion
    @EstacionID = 1,
    @CarrilID = 1,
    @TipoVehiculoID = 1,
    @Placa = 'ABC123',
    @MetodoPago = 'Efectivo',
    @OperadorID = 'operador1',
    @Observaciones = 'Transacción normal',
    @TransaccionID = @TransaccionID OUTPUT;

-- Transacción 2: Vehículo categoría 2 con tarjeta
EXEC peaje.sp_RegistrarTransaccion
    @EstacionID = 1,
    @CarrilID = 2,
    @TipoVehiculoID = 2,
    @Placa = 'XYZ789',
    @MetodoPago = 'Tarjeta',
    @OperadorID = 'operador1',
    @Observaciones = 'Pago con tarjeta',
    @TransaccionID = @TransaccionID OUTPUT;

-- Transacción 3: Vehículo categoría 1 con telepeaje
EXEC peaje.sp_RegistrarTransaccion
    @EstacionID = 2,
    @CarrilID = 5,
    @TipoVehiculoID = 1,
    @Placa = 'DEF456',
    @MetodoPago = 'Telepeaje',
    @OperadorID = NULL,
    @Observaciones = 'Paso automático',
    @TransaccionID = @TransaccionID OUTPUT;

PRINT 'Transacciones de ejemplo insertadas';

-- Insertar algunos eventos de tránsito
DECLARE @EventoID BIGINT;

EXEC peaje.sp_RegistrarEventoTransito
    @EstacionID = 1,
    @CarrilID = 1,
    @TipoEvento = 'VehiculoDetectado',
    @PlacaDetectada = 'GHI789',
    @ClaseVehicularDetectada = 'AUTO',
    @Velocidad = 25.5,
    @EventoID = @EventoID OUTPUT;

EXEC peaje.sp_RegistrarEventoTransito
    @EstacionID = 1,
    @CarrilID = 1,
    @TipoEvento = 'PagoRealizado',
    @PlacaDetectada = 'GHI789',
    @TarjetaRFID = 'RFID001234567892',
    @EventoID = @EventoID OUTPUT;

EXEC peaje.sp_RegistrarEventoTransito
    @EstacionID = 2,
    @CarrilID = 5,
    @TipoEvento = 'BarreraAbierta',
    @PlacaDetectada = 'JKL012',
    @Velocidad = 30.0,
    @EventoID = @EventoID OUTPUT;

PRINT 'Eventos de tránsito de ejemplo insertados';

-- Insertar log de auditoría de ejemplo
INSERT INTO [auditoria].[LogsAuditoria] (
    TipoOperacion, TablaAfectada, RegistroID, UsuarioID, 
    DireccionIP, Aplicacion, Descripcion
)
VALUES 
    ('LOGIN', NULL, NULL, 'admin', '192.168.1.100', 'Sistema Peaje Web', 'Inicio de sesión administrativo'),
    ('INSERT', 'Transacciones', '1', 'operador1', '192.168.1.101', 'Terminal Peaje', 'Nueva transacción registrada'),
    ('UPDATE', 'Tarifas', '1', 'admin', '192.168.1.100', 'Sistema Peaje Web', 'Actualización de tarifa'),
    ('LOGIN', NULL, NULL, 'operador1', '192.168.1.101', 'Terminal Peaje', 'Inicio de turno'),
    ('LOGOUT', NULL, NULL, 'operador1', '192.168.1.101', 'Terminal Peaje', 'Fin de turno');

PRINT 'Logs de auditoría de ejemplo insertados';
GO
