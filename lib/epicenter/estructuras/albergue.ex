defmodule Epicenter.Albergue do
  @moduledoc """
  Albergue. La ocupación actual es `MapSet.size(ocupantes)`, así una misma
  persona no puede contarse dos veces.
  """

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          nombre: String.t() | nil,
          zona: String.t() | nil,
          capacidad: non_neg_integer(),
          ocupantes: MapSet.t(String.t()),
          recursos: MapSet.t(String.t()),
          necesidades: MapSet.t(String.t())
        }

  defstruct codigo: nil,
            nombre: nil,
            zona: nil,
            capacidad: 0,
            ocupantes: MapSet.new(),
            recursos: MapSet.new(),
            necesidades: MapSet.new()
end
