defmodule Epicenter.Recurso do
  @moduledoc """
  Existencias de un recurso en una ubicación.

  Una transferencia deja el mismo código en dos lugares, así que la clave del
  inventario es `{codigo, ubicacion}`.
  """

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          nombre: String.t() | nil,
          categoria: atom(),
          cantidad: non_neg_integer(),
          unidad: String.t() | nil,
          ubicacion: String.t() | nil
        }

  defstruct codigo: nil, nombre: nil, categoria: :otra, cantidad: 0, unidad: nil, ubicacion: nil
end
