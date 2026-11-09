defmodule Epicenter.Inventario do
  @moduledoc """
  Existencias de un recurso en un centro de apoyo.

  `codigo_recurso` apunta a `Epicenter.Recurso.codigo` y `codigo_centro` a
  `Epicenter.CentroApoyo.codigo`. Hay un inventario por cada par recurso y centro;
  `cantidad_disponible` nunca puede quedar negativa.
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          codigo_recurso: String.t() | nil,
          codigo_centro: String.t() | nil,
          cantidad_disponible: non_neg_integer()
        }

  defstruct id: nil, codigo_recurso: nil, codigo_centro: nil, cantidad_disponible: 0
end
