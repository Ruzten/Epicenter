# Comandos

Esta es la lista oficial. Coincide con `lib/epicenter/comandos/catalogo.ex`.

Los comandos marcados con `*` no aparecen en el PDF, pero cubren funciones que este exige.

Los datos con espacios van entre comillas, como `"Albergue Norte"`.

## Persona A: usuarios y resumen

| Comando | Rol mínimo |
| --- | --- |
| `connect usuario contraseña [tipo zona]` | Sin sesión |
| `help` * | Sin sesión |
| `disconnect` | Ciudadano |
| `summary` | Coordinador |
| `activity usuario` * | Administrador |

## Persona B: necesidades y recursos

| Comando | Rol mínimo |
| --- | --- |
| `register_need tipo cantidad prioridad zona "descripcion"` | Ciudadano |
| `list_needs [zona=x] [tipo=x] [prioridad=x] [estado=x]` | Ciudadano |
| `pending_needs` | Ciudadano |
| `list_resources [tipo=x] [zona=x]` | Ciudadano |
| `critical_resources` | Ciudadano |
| `update_need id estado` * | Coordinador |
| `cancel_need id` * | Coordinador |
| `register_center codigo "nombre" tipo zona` * | Coordinador |
| `register_resource codigo nombre cantidad unidad ubicacion` | Coordinador |
| `stock_in codigo ubicacion cantidad` * | Coordinador |
| `stock_out codigo ubicacion cantidad` * | Coordinador |
| `resource_history codigo` * | Coordinador |
| `transfer_resource codigo origen destino cantidad` | Coordinador |
| `assign_resource necesidad tipo cantidad` | Coordinador |

## Persona C: zonas

| Comando | Rol mínimo |
| --- | --- |
| `zone_status codigo` * | Ciudadano |
| `zone_stats codigo` * | Ciudadano |
| `register_zone codigo "nombre" nivel` | Coordinador |
| `register_sector zona codigo "nombre" nivel` * | Coordinador |
| `register_point sector codigo "nombre"` * | Coordinador |

## Persona C: personas y mensajes

| Comando | Rol mínimo |
| --- | --- |
| `report_person documento "nombre" zona estado` | Ciudadano |
| `find_person documento` | Ciudadano |
| `search_people [nombre=x] [zona=x] [estado=x]` * | Ciudadano |
| `send_family_message documento "mensaje"` | Ciudadano |
| `list_family_messages documento` | Ciudadano |
| `update_person documento estado` * | Voluntario |
| `deliver_message id` * | Voluntario |

## Persona C: albergues

| Comando | Rol mínimo |
| --- | --- |
| `check_shelter codigo` | Ciudadano |
| `shelter_ranking` * | Ciudadano |
| `register_shelter codigo "nombre" zona capacidad` | Coordinador |
| `register_entry codigo documento` | Coordinador |
| `register_exit codigo documento` | Coordinador |
| `link_shelter codigo need\|resource id` * | Coordinador |

## Persona C: mascotas

| Comando | Rol mínimo |
| --- | --- |
| `report_pet lost\|found especie "nombre" color tamaño zona contacto` | Ciudadano |
| `list_pets [especie=x] [zona=x] [estado=x]` * | Ciudadano |
| `match_pets` | Voluntario |
| `confirm_pet_match id_perdida id_encontrada` * | Voluntario |
