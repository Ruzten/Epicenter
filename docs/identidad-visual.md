# Identidad visual de Epicenter

Versión navegable con vistas previas: [sistema de diseño de Epicenter](https://claude.ai/artifact/JTViGNzS5efEnf3usVXjbh).

Archivos en este repositorio:

- `assets/css/epicenter.css`: tokens de color, tipografía, espaciado y componentes `ep-`.
- `priv/static/images/`: las tres versiones del isotipo.

Epicenter coordina la atención después de un terremoto: necesidades, recursos, personas, albergues y mascotas. La interfaz se usa bajo presión, en equipos prestados y con mala conexión. Cada decisión visual prioriza leer rápido qué es urgente, qué falta y qué ya se resolvió.

## Principios

- **La urgencia manda.** Lo crítico se ve primero: va arriba, en `critico` y con su palabra. Nada decorativo compite con un estado.
- **Calma en la estructura, color en las señales.** Fondos y superficies son neutros (`suelo`, `superficie`). El color se reserva para la acción principal (`marca`) y los estados.
- **Nunca solo color.** Cada nivel, prioridad o estado lleva su palabra. Crítico y resuelto también se distinguen por claridad, no solo por tono.
- **Datos exactos.** Códigos, documentos y cantidades van en `datos` con su unidad: `30 L`, `R001`, `150/150`.

## Voz y tono

- Escribe en español, en segunda persona (tú) y con verbos directos: “Asignar recurso”, “Registrar ingreso”.
- Los botones dicen lo que pasa. Después de actuar, confirma con el mismo verbo: “Recurso asignado”.
- Los errores dicen qué pasó, con datos, y cómo seguir. Sin disculpas ni signos de exclamación.
  - Bien: “No hay suficiente agua en centro_acopio_1. Quedan 20 L y pediste 25 L.”
  - Mal: “¡Ups! Algo salió mal.”
- Usa los nombres del dominio: necesidad, recurso, albergue, zona, reporte. Nunca nombres internos como `:inventario_insuficiente`.
- Escribe estados con mayúscula inicial y sin guion bajo: “En atención”, “Sin información”.
- No uses emoji.

## Logo

- El isotipo es un trazo de sismógrafo dentro de un cuadrado con `radio-lg`. Representa el momento del sismo y la señal de que alguien está atendiendo.
- Usa `epicenter-isotipo.svg` sobre fondos claros, `epicenter-isotipo-claro.svg` sobre fondos oscuros y `epicenter-isotipo-tinta.svg` para impresión a una tinta.
- Escribe el nombre en HTML, no en imagen: “Epicenter” en `display` (Archivo 800), color `tinta`, a la derecha del isotipo y separado por `espacio-2`.
- Tamaño mínimo del isotipo: 24px. Déjale libre alrededor un espacio igual a una cuarta parte de su lado.
- No cambies sus colores, no lo rotes y no le agregues sombras.

## Color

- Usa `suelo` como fondo de página y `superficie` para tarjetas, tablas y formularios. Separa con `linea`, no con sombras.
- Usa `tinta` para el texto principal y `tinta-suave` para el secundario.
- Usa `marca` solo en el botón principal y el isotipo: un botón principal por vista.
- Usa la escala de urgencia para niveles de zona y prioridades:

| Valor | Token de fondo | Token de texto |
| --- | --- | --- |
| Crítico / crítica | `critico` | `sobre-critico` |
| Alto / alta | `alto` | `sobre-alto` |
| Medio / media | `medio` | `sobre-medio` |
| Bajo / baja | `bajo` | `sobre-bajo` |

- Usa los colores de estado así:

| Estado | Token |
| --- | --- |
| Pendiente, sin información, cancelada | `tinta-suave` |
| Asignada, en atención, reportada, trasladada, activa | `info` |
| Posible coincidencia | `medio` |
| Atendida, localizada, en albergue, reunificada, resuelta, entregado | `resuelto` |

- Los avisos usan su fondo suave con texto `tinta`: `fondo-info`, `fondo-resuelto`, `fondo-alto` y `fondo-critico`.
- Los textos cumplen 4.5:1 en ambos temas; los bordes de controles y el foco cumplen 3:1.

## Tipografía

- `display` (Archivo): títulos y el nombre del producto. Usa `display` una sola vez por pantalla.
- `texto` (Public Sans): todo el contenido. Es una fuente civil y muy legible en tamaños pequeños.
- `datos` (IBM Plex Mono): identificadores, documentos, cantidades y fechas.
- Escala: `display`, `titulo-1`, `titulo-2`, `titulo-3`, `cuerpo`, `cuerpo-sm`, `etiqueta`, `dato`, `dato-grande`. No inventes tamaños intermedios.
- Escribe `etiqueta` en mayúsculas.
- Alinea las cifras a la derecha en tablas y usa `font-variant-numeric: tabular-nums`.

## Espaciado, bordes y forma

- Todo se alinea en una cuadrícula de 4px: `espacio-1` a `espacio-12`.
- Las esquinas son casi rectas, como la señalización de emergencia: `radio-sm` para etiquetas, `radio-md` para controles y `radio-lg` para tarjetas.
- Usa `sombra-flotante` solo en menús y diálogos que flotan sobre la página.
- El foco de teclado es un contorno sólido de 2px en `foco`, separado 2px del control.

## Movimiento

- Usa transiciones de 120 ms solo para hover y foco.
- No animes estados ni cifras: un cambio de inventario debe verse al instante.
- Respeta `prefers-reduced-motion`.

## Iconografía

- Usa [Heroicons](https://heroicons.com), que Phoenix ya incluye con `<.icon name="hero-…" />`.
- Usa la variante outline de 20px junto a texto y la variante solid de 16px dentro de etiquetas.
- Iconos sugeridos: agua `hero-beaker`, recursos `hero-cube`, albergue `hero-home-modern`, personas `hero-user-group`, mensajes `hero-chat-bubble-left-right`, mascotas `hero-heart`, zona `hero-map-pin`, alerta `hero-exclamation-triangle`, resuelto `hero-check-circle`.
- Ningún icono reemplaza la palabra de un estado.

## Componentes

Todos son clases CSS con prefijo `ep-`, así funcionan directamente en plantillas HEEx de Phoenix:

- `Boton`: acciones.
- `Etiqueta`: niveles, prioridades y estados.
- `Campo`: entradas de formulario con rótulo, ayuda y error.
- `Aviso`: mensajes flash de Phoenix.
- `Tabla`: listados de necesidades, recursos, personas y reportes.
- `Medidor`: ocupación de albergues.
- `Indicador`: cifras del resumen global.

## Uso con Phoenix

La interfaz está en la carpeta `Phoenix/` y no usa Tailwind ni daisyUI: los estilos son CSS puro.

- `Phoenix/priv/static/assets/epicenter.css`: tokens, componentes `ep-` y pantallas.
- `Phoenix/priv/static/images/`: las tres versiones del isotipo.
- `Phoenix/lib/epicenter_web/componentes/plantillas/raiz.html.heex`: carga las fuentes y la hoja de estilos.
- `Phoenix/lib/epicenter_web/componentes/componentes.ex`: componentes HEEx como `<.campo>`, `<.avisos>` e `<.isotipo>`.

El tema sigue el del sistema operativo. Para forzar uno, pon `data-theme="light"` o `data-theme="dark"` en `<html>`.
