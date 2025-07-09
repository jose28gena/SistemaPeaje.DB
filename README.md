# Sistema de Peaje - Base de Datos

Este proyecto contiene la estructura de base de datos para el Sistema de Peaje implementado en SQL Server.

## Estructura del Proyecto

```
SistemaPeaje.DB/
├── Database/
│   ├── Schemas/          # Esquemas de la base de datos
│   ├── Tables/           # Definiciones de tablas
│   ├── Views/            # Vistas
│   ├── StoredProcedures/ # Procedimientos almacenados
│   ├── Functions/        # Funciones definidas por el usuario
│   ├── Triggers/         # Triggers
│   └── Indexes/          # Índices adicionales
├── Scripts/
│   ├── Deployment/       # Scripts de despliegue
│   └── SeedData/         # Datos iniciales
├── Tests/                # Pruebas unitarias para la BD
└── Documentation/        # Documentación del proyecto
```

## Requisitos

- SQL Server 2019 o superior
- SQL Server Management Studio (SSMS)
- Visual Studio Code con extensión SQL Server

## Instalación

1. Ejecutar los scripts en el siguiente orden:
   - `Scripts/Deployment/01_CreateDatabase.sql`
   - `Database/Schemas/*.sql`
   - `Database/Tables/*.sql`
   - `Database/Functions/*.sql`
   - `Database/StoredProcedures/*.sql`
   - `Database/Views/*.sql`
   - `Database/Triggers/*.sql`
   - `Scripts/SeedData/*.sql`

## Esquemas Principales

- **dbo**: Esquema por defecto
- **peaje**: Esquema principal del sistema de peaje
- **seguridad**: Esquema para gestión de usuarios y permisos
- **auditoria**: Esquema para auditoría y logs

## Documentación

Para más información, consulte la documentación en la carpeta `Documentation/`.
