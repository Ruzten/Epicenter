# Epicenter Web

Interfaz gráfica de Epicenter hecha con Phoenix. Usa el núcleo de la carpeta superior como dependencia (`{:epicenter, path: ".."}`), así que toda la lógica sigue en `lib/epicenter/`.

> **Estado:** solo está la pantalla de ingreso y una página de inicio temporal.

## Ejecutar

Desde esta carpeta:

```bash
mix setup
```

```bash
mix phx.server
```

Abre <http://localhost:4000/ingresar>.

Pruebas:

```bash
mix test
```

## Pantallas

| Ruta | Pantalla |
| --- | --- |
| `GET /ingresar` | Formulario de ingreso |
| `POST /ingresar` | Llama a `Epicenter.Usuarios.conectar/4` |
| `DELETE /salir` | Cierra la sesión |
| `GET /` | Inicio temporal; exige sesión |

## Lo que la interfaz espera del núcleo

`Epicenter.Usuarios.conectar(usuario, contrasena, tipo, zona)` debe devolver:

- `{:ok, %Epicenter.Usuario{}}` cuando el ingreso o el registro funciona.
- `{:error, motivo}` cuando falla. La pantalla ya tiene mensajes para estos motivos:

| Motivo | Mensaje |
| --- | --- |
| `:contrasena_incorrecta` | La contraseña no coincide con la de este usuario. |
| `:faltan_datos_registro` | Es tu primera vez: elige tu tipo de usuario y tu zona. |
| `:tipo_invalido` | Elige un tipo de usuario válido. |
| `:argumentos_invalidos` | Revisa los datos: falta alguno o no es válido. |
| `:no_implementado` | El ingreso todavía no funciona: falta programar `Epicenter.Usuarios.conectar/4`. |

`tipo` y `zona` llegan como texto o `nil`. Mientras `conectar/4` no esté programada, la pantalla muestra el aviso de `:no_implementado`.

## Estructura

- `lib/epicenter_web/router.ex`: rutas y protección de sesión.
- `lib/epicenter_web/controladores/`: controladores y plantillas de cada pantalla.
- `lib/epicenter_web/componentes/`: plantilla raíz y componentes HEEx.
- `priv/static/assets/epicenter.css`: estilos de la identidad visual.
- `priv/static/images/`: isotipos.
- `test/`: pruebas de las pantallas.
