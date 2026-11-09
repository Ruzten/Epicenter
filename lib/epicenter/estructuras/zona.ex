defmodule Epicenter.Zona do
  @moduledoc """
  Zona afectada. Es la raíz del árbol zona -> sectores -> puntos de atención.

  `sectores` contiene `%Epicenter.Sector{}` y cada sector contiene sus
  `%Epicenter.PuntoAtencion{}`. Las estadísticas de una zona se calculan
  recorriendo ese árbol con funciones recursivas.
  """

  @type nivel :: :critico | :alto | :medio | :bajo

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          nombre: String.t() | nil,
          nivel_afectacion: nivel(),
          personas_afectadas: non_neg_integer(),
          sectores: [Epicenter.Sector.t()]
        }

  defstruct codigo: nil,
            nombre: nil,
            nivel_afectacion: :bajo,
            personas_afectadas: 0,
            sectores: []
end
