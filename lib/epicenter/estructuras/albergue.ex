defmodule Epicenter.Albergue do
  @moduledoc """
  Albergue.

  - `codigo` es también el código de su `Epicenter.CentroApoyo` (tipo albergue).
  - `codigo_zona` apunta a `Epicenter.Zona.codigo`.
  - `ocupantes` guarda documentos de `Epicenter.Persona`. La ocupación actual es
    `MapSet.size(ocupantes)`, así una misma persona no puede contarse dos veces, y
    los cupos disponibles son `capacidad - MapSet.size(ocupantes)`.
  - `recursos` y `necesidades` guardan los códigos e identificadores asociados.
  """

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          nombre: String.t() | nil,
          codigo_zona: String.t() | nil,
          capacidad: non_neg_integer(),
          ocupantes: MapSet.t(String.t()),
          recursos: MapSet.t(String.t()),
          necesidades: MapSet.t(String.t())
        }

  defstruct codigo: nil,
            nombre: nil,
            codigo_zona: nil,
            capacidad: 0,
            ocupantes: MapSet.new(),
            recursos: MapSet.new(),
            necesidades: MapSet.new()
end
