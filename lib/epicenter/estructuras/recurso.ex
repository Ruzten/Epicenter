defmodule Epicenter.Recurso do
  @moduledoc """
  Catálogo de recursos: qué es cada código, sin cantidades.

  Las existencias de cada centro van en `Epicenter.Inventario`.
  """

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          nombre: String.t() | nil,
          categoria: atom(),
          unidad_medida: String.t() | nil
        }

  defstruct codigo: nil, nombre: nil, categoria: :otra, unidad_medida: nil
end
