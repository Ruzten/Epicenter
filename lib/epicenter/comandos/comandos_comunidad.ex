defmodule Epicenter.Comandos.ComandosComunidad do
  @moduledoc """
  Comandos de zonas, personas, albergues y mascotas. Responsable: Persona C.

  Los datos llegan como texto; cada módulo debe validarlos y convertirlos.
  """

  alias Epicenter.Comandos.Filtros
  alias Epicenter.{Comunidad, Mascotas, Zonas}

  @spec manejar([String.t()], Epicenter.Usuario.t()) :: Epicenter.resultado()
  def manejar(["register_zone", codigo, nombre, nivel], _usuario) do
    Zonas.registrar_zona(%{codigo: codigo, nombre: nombre, nivel: nivel})
  end

  def manejar(["register_sector", zona, codigo, nombre, nivel], _usuario) do
    Zonas.registrar_sector(zona, %{codigo: codigo, nombre: nombre, nivel: nivel})
  end

  def manejar(["register_point", sector, codigo, nombre], _usuario) do
    Zonas.registrar_punto(sector, %{codigo: codigo, nombre: nombre})
  end

  def manejar(["zone_status", codigo], _usuario), do: Zonas.estado_zona(codigo)
  def manejar(["zone_stats", codigo], _usuario), do: Zonas.estadisticas_zona(codigo)

  def manejar(["report_person", documento, nombre, zona, estado], usuario) do
    Comunidad.reportar_persona(%{
      documento: documento,
      nombre: nombre,
      zona: zona,
      estado: estado,
      usuario: usuario.nombre_usuario
    })
  end

  def manejar(["find_person", documento], _usuario), do: Comunidad.buscar_persona(documento)

  def manejar(["search_people" | filtros], _usuario) do
    Comunidad.buscar_personas(Filtros.analizar(filtros))
  end

  def manejar(["update_person", documento, estado], usuario) do
    Comunidad.actualizar_persona(documento, estado, usuario.nombre_usuario)
  end

  def manejar(["send_family_message", documento, contenido], usuario) do
    Comunidad.enviar_mensaje_familiar(documento, contenido, usuario.nombre_usuario)
  end

  def manejar(["list_family_messages", documento], _usuario) do
    Comunidad.listar_mensajes_familiares(documento)
  end

  def manejar(["deliver_message", id], _usuario), do: Comunidad.entregar_mensaje(id)

  def manejar(["register_shelter", codigo, nombre, zona, capacidad], _usuario) do
    Comunidad.registrar_albergue(%{
      codigo: codigo,
      nombre: nombre,
      zona: zona,
      capacidad: capacidad
    })
  end

  def manejar(["check_shelter", codigo], _usuario), do: Comunidad.consultar_albergue(codigo)

  def manejar(["register_entry", codigo, documento], usuario) do
    Comunidad.registrar_ingreso(codigo, documento, usuario.nombre_usuario)
  end

  def manejar(["register_exit", codigo, documento], usuario) do
    Comunidad.registrar_salida(codigo, documento, usuario.nombre_usuario)
  end

  def manejar(["link_shelter", codigo, tipo, id], _usuario) do
    Comunidad.vincular_albergue(codigo, tipo, id)
  end

  def manejar(["shelter_ranking"], _usuario), do: Comunidad.ranking_albergues()

  def manejar(["report_pet", tipo, especie, nombre, color, tamano, zona, contacto], _usuario) do
    Mascotas.reportar_mascota(%{
      tipo_reporte: tipo,
      especie: especie,
      nombre: nombre,
      color: color,
      tamano: tamano,
      zona: zona,
      contacto: contacto
    })
  end

  def manejar(["list_pets" | filtros], _usuario) do
    Mascotas.listar_mascotas(Filtros.analizar(filtros))
  end

  def manejar(["match_pets"], _usuario), do: Mascotas.buscar_coincidencias()

  def manejar(["confirm_pet_match", id_perdida, id_encontrada], usuario) do
    Mascotas.confirmar_coincidencia(id_perdida, id_encontrada, usuario.nombre_usuario)
  end

  def manejar(_tokens, _usuario), do: {:error, :argumentos_invalidos}
end
