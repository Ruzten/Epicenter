defmodule Epicenter.Comandos.ComandosLogistica do
  @moduledoc """
  Comandos de necesidades y recursos. Responsable: Persona B.

  Los datos llegan como texto; `Logistica` debe validarlos y convertirlos.
  """

  alias Epicenter.Comandos.Filtros
  alias Epicenter.Logistica

  @spec manejar([String.t()], Epicenter.Usuario.t()) :: Epicenter.resultado()
  def manejar(["register_need", tipo, cantidad, prioridad, zona, descripcion], usuario) do
    Logistica.registrar_necesidad(%{
      tipo: tipo,
      cantidad: cantidad,
      prioridad: prioridad,
      codigo_zona: zona,
      descripcion: descripcion,
      reportado_por: usuario.nombre_usuario
    })
  end

  def manejar(["list_needs" | filtros], _usuario) do
    Logistica.listar_necesidades(Filtros.analizar(filtros))
  end

  def manejar(["pending_needs"], _usuario), do: Logistica.necesidades_pendientes()

  def manejar(["update_need", id, estado], usuario) do
    Logistica.actualizar_necesidad(id, estado, usuario.nombre_usuario)
  end

  def manejar(["cancel_need", id], usuario) do
    Logistica.cancelar_necesidad(id, usuario.nombre_usuario)
  end

  def manejar(["register_center", codigo, nombre, tipo, zona], _usuario) do
    Logistica.registrar_centro(%{codigo: codigo, nombre: nombre, tipo: tipo, codigo_zona: zona})
  end

  def manejar(["register_resource", codigo, nombre, cantidad, unidad, ubicacion], usuario) do
    Logistica.registrar_recurso(%{
      codigo: codigo,
      nombre: nombre,
      cantidad: cantidad,
      unidad_medida: unidad,
      codigo_centro: ubicacion,
      usuario: usuario.nombre_usuario
    })
  end

  def manejar(["list_resources" | filtros], _usuario) do
    Logistica.listar_recursos(Filtros.analizar(filtros))
  end

  def manejar(["stock_in", codigo, ubicacion, cantidad], usuario) do
    Logistica.entrada_inventario(codigo, ubicacion, cantidad, usuario.nombre_usuario)
  end

  def manejar(["stock_out", codigo, ubicacion, cantidad], usuario) do
    Logistica.salida_inventario(codigo, ubicacion, cantidad, usuario.nombre_usuario)
  end

  def manejar(["resource_history", codigo], _usuario), do: Logistica.historial_recurso(codigo)

  def manejar(["transfer_resource", codigo, origen, destino, cantidad], usuario) do
    Logistica.transferir_recurso(codigo, origen, destino, cantidad, usuario.nombre_usuario)
  end

  def manejar(["assign_resource", necesidad_id, tipo, cantidad], usuario) do
    Logistica.asignar_recurso(necesidad_id, tipo, cantidad, usuario.nombre_usuario)
  end

  def manejar(["critical_resources"], _usuario), do: Logistica.recursos_criticos()
  def manejar(_tokens, _usuario), do: {:error, :argumentos_invalidos}
end
