defmodule Epicenter.PuntoAtencion do
  @moduledoc """
  Punto de atención dentro de un sector. `codigo_sector` apunta a `Epicenter.Sector.codigo`.
  """

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          codigo_sector: String.t() | nil,
          nombre: String.t() | nil
        }

  defstruct codigo: nil, codigo_sector: nil, nombre: nil
end
