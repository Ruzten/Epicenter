# Decisiones del proyecto

Estas son las reglas oficiales del proyecto.

| Tema | Decisión |
| --- | --- |
| Conexión | Una consola, un proceso por sesión y usuarios simulados con `Task` |
| Ciudadano | Registra y consulta |
| Voluntario | Lo anterior, más gestión de mascotas y personas |
| Coordinador | Lo anterior, más zonas, recursos, asignaciones y albergues |
| Administrador | Puede hacer todo |
| Autorregistro | `administrador` no se puede elegir en `connect`; se crea directamente en `Usuarios` |
| Tipos de usuario | `ciudadano`, `voluntario`, `coordinador`, `administrador` |
| Prioridad | `critica` > `alta` > `media` > `baja` |
| Nivel de zona | `critico`, `alto`, `medio`, `bajo` |
| Necesidades | `pendiente → asignada → en_atencion → atendida`; cualquiera no cerrada puede pasar a `cancelada` |
| Personas | `sin_informacion`, `reportada`, `localizada`, `trasladada`, `en_albergue`, `reunificada` |
| Inventario insuficiente | Se rechaza la asignación completa |
| Cancelación | Una necesidad asignada devuelve sus recursos |
| Recurso crítico | Quedan menos de 10 unidades |
| Mascotas | Especie 40, color 25, tamaño 15 y zona 20; desde 60 puntos es posible coincidencia |
| Persistencia | `Almacen.guardar/2` y `Almacen.cargar/2` guardan el estado con `inspect` en texto plano |
| Contraseñas | Se guardan con hash |
| Respuestas | `{:ok, valor}` o `{:error, motivo}` |
| Idioma | El código está en español; los comandos usan los nombres del enunciado |

## Errores comunes

| Error | Significado |
| --- | --- |
| `:comando_vacio` | No se escribió ningún comando |
| `:comando_desconocido` | El comando no existe |
| `:argumentos_invalidos` | Faltan datos o sobran |
| `:sin_sesion` | Se necesita iniciar sesión |
| `:prohibido` | El rol no tiene permiso |
| `:no_encontrado` | El registro no existe |
| `:ya_existe` | El identificador ya existe |
| `:cantidad_invalida` | La cantidad no es un entero válido |
| `:transicion_invalida` | El cambio de estado no está permitido |
| `:ya_cerrado` | La necesidad o el reporte ya estaba cerrado |
| `:inventario_insuficiente` | El inventario no alcanza |
| `:albergue_lleno` | El albergue no tiene cupo |
| `:no_implementado` | La función todavía no se ha programado |

## Reglas de código

- La clave del inventario es `{codigo, ubicacion}`, porque una transferencia deja el mismo código en dos lugares.
- Cada GenServer guarda con `Almacen.guardar/2` antes de responder.
- Solo `Comunidad` cambia el estado de una persona al entrar o salir de un albergue.
- Cada persona edita solo sus módulos. Si necesita cambiar una estructura compartida o una firma pública, avisa antes.

## Cómo agregar la lógica

1. Busca la función pública en tu módulo. Su mensaje ya está definido.
2. Agrega un `handle_call` para ese mensaje encima de la cláusula final.
3. Valida los datos y devuelve `{:ok, valor}` o `{:error, motivo}`.
4. Guarda con `Almacen.guardar/2` antes de responder.
5. Agrega sus pruebas.

```elixir
def handle_call({:cancelar_necesidad, id, usuario}, _origen, estado) do
  # Tu lógica aquí.
  {:reply, {:error, :no_encontrado}, estado}
end
```

## Responsables

| Persona | Módulos |
| --- | --- |
| A | `Almacen`, `RegistroActividad`, `Usuarios`, `Sesion`, `Analizador`, `Consola`, `Resumen`, `ComandosPlataforma` |
| B | `Logistica`, `ComandosLogistica` |
| C | `Zonas`, `Comunidad`, `Mascotas`, `ComandosComunidad` |
