defmodule Epicenter.Zona do
  @moduledoc """
  Nodo del árbol zona -> sectores -> puntos de atención.

  `hijos` contiene otros `%Epicenter.Zona{}`, lo que permite recorrer el árbol
  con funciones recursivas.
  """

  @type tipo :: :zona | :sector | :punto
  @type nivel :: :critico | :alto | :medio | :bajo

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          nombre: String.t() | nil,
          tipo: tipo(),
          nivel: nivel(),
          afectados: non_neg_integer(),
          hijos: [t()]
        }

  defstruct codigo: nil, nombre: nil, tipo: :zona, nivel: :bajo, afectados: 0, hijos: []
end
