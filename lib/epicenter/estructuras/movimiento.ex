defmodule Epicenter.Movimiento do
  @moduledoc """
  Registro del historial de inventario. Nunca se borra.

  - `id_inventario` apunta a `Epicenter.Inventario.id`.
  - `usuario` apunta a `Epicenter.Usuario.nombre_usuario`.
  - `id_necesidad` apunta a `Epicenter.Necesidad.id` en asignaciones y devoluciones.
  - `codigo_destino` apunta a `Epicenter.CentroApoyo.codigo` en transferencias.
  """

  @type tipo :: :entrada | :salida | :asignacion | :devolucion | :transferencia

  @type t :: %__MODULE__{
          id: String.t() | nil,
          id_inventario: String.t() | nil,
          tipo: tipo(),
          cantidad: pos_integer() | nil,
          fecha: DateTime.t() | nil,
          usuario: String.t() | nil,
          id_necesidad: String.t() | nil,
          codigo_destino: String.t() | nil
        }

  defstruct id: nil,
            id_inventario: nil,
            tipo: :entrada,
            cantidad: nil,
            fecha: nil,
            usuario: nil,
            id_necesidad: nil,
            codigo_destino: nil
end
