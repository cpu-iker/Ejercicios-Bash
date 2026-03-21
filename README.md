# Ejercicios de scripts en Bash

Dos ejercicios prácticos para aprender Bash: un gestor de ficheros con logs y un script para detectar de palíndromos (palabras que son la misma al revés).

## 1. Gestor de Ficheros (`ficheros.sh`)

**Objetivo:** Crear un menú interactivo para gestionar ficheros (crear, editar, borrar) con un sistema de logs que registra todas las operaciones.

**Funcionalidades:**
- Crear nuevos ficheros con validación
- Editar ficheros con nano
- Ver historial de logs (con fecha y hora)
- Borrar ficheros con confirmación
- Registro automático de todas las acciones en `logs.txt`

**Ejecutar:**
```bash
bash ficheros.sh
```

## 2. Validador de Palíndromos (`palindroma.sh`)

**Objetivo:** Crear un validador que compruebe si palabras de 5 letras minúsculas son palíndromos (se leen igual de izquierda a derecha que de derecha a izquierda).

**Funcionalidades:**
- Validación de exactamente 5 caracteres
- Solo acepta letras minúsculas (a-z)
- Permite múltiples consultas en la misma sesión
- Escribe "zzzzz" para salir

**Ejecutar:**
```bash
bash palindroma.sh
```

Palabras para probar: `radar`, `level`, `civic`, `kayak` (palíndromos), o `casa`, `hello` (no palindromos)

## Estructura

```
├── ficheros.sh
├── palindroma.sh
├── README.md
└── LICENSE (MIT)
```
