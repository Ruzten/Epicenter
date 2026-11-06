defmodule Epicenter.Almacen do
  @moduledoc """
  Persistencia en archivos de texto plano.

  Responsable: Persona A. Por ahora es un stub: `guardar/2` no escribe nada y
  `cargar/2` siempre devuelve el valor por defecto. Las firmas no deben cambiar.
  """

  @spec guardar(atom(), term()) :: :ok | {:error, term()}
  def guardar(_nombre, _estado), do: :ok

  @spec cargar(atom(), term()) :: term()
  def cargar(_nombre, valor_por_defecto), do: valor_por_defecto
end
