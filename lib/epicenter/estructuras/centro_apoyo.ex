defmodule Epicenter.CentroApoyo do
  @moduledoc """
  Lugar que guarda inventario: centro de acopio, albergue o punto de atención.

  `codigo_zona` apunta a `Epicenter.Zona.codigo`. Cada albergue tiene también un
  centro de apoyo con el mismo código y `tipo: :albergue`, para poder recibir recursos.
  """

  @type tipo :: :centro_acopio | :albergue | :punto_atencion

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          nombre: String.t() | nil,
          tipo: tipo(),
          codigo_zona: String.t() | nil
        }

  defstruct codigo: nil, nombre: nil, tipo: :centro_acopio, codigo_zona: nil
end
