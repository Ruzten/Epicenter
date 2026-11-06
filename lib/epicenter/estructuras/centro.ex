defmodule Epicenter.Centro do
  @moduledoc "Centro de apoyo: centro de acopio, albergue o punto de atención."

  @type tipo :: :centro_acopio | :albergue | :punto_atencion

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          nombre: String.t() | nil,
          tipo: tipo(),
          zona: String.t() | nil
        }

  defstruct codigo: nil, nombre: nil, tipo: :centro_acopio, zona: nil
end
