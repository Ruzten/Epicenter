defmodule Epicenter.Movimiento do
  @moduledoc "Registro del historial de inventario."

  @type tipo :: :entrada | :salida | :asignacion | :devolucion | :transferencia

  @type t :: %__MODULE__{
          id: String.t() | nil,
          tipo: tipo(),
          codigo_recurso: String.t() | nil,
          cantidad: pos_integer() | nil,
          origen: String.t() | nil,
          destino: String.t() | nil,
          necesidad_id: String.t() | nil,
          usuario: String.t() | nil,
          fecha: DateTime.t() | nil
        }

  defstruct id: nil,
            tipo: :entrada,
            codigo_recurso: nil,
            cantidad: nil,
            origen: nil,
            destino: nil,
            necesidad_id: nil,
            usuario: nil,
            fecha: nil
end
