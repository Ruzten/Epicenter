defmodule Epicenter.Mascota do
  @moduledoc """
  Reporte de mascota perdida o encontrada.

  - `codigo_zona` apunta a `Epicenter.Zona.codigo`.
  - `coincide_con` apunta al `id` de otra `Epicenter.Mascota` cuando se confirma
    una coincidencia; ambos reportes quedan resueltos.
  """

  @type tipo_reporte :: :perdida | :encontrada
  @type estado :: :activa | :posible_coincidencia | :resuelta

  @type t :: %__MODULE__{
          id: String.t() | nil,
          tipo_reporte: tipo_reporte(),
          especie: String.t() | nil,
          nombre: String.t() | nil,
          caracteristicas: String.t(),
          color: String.t() | nil,
          tamano: String.t() | nil,
          codigo_zona: String.t() | nil,
          contacto: String.t() | nil,
          estado: estado(),
          coincide_con: String.t() | nil
        }

  defstruct id: nil,
            tipo_reporte: :perdida,
            especie: nil,
            nombre: nil,
            caracteristicas: "",
            color: nil,
            tamano: nil,
            codigo_zona: nil,
            contacto: nil,
            estado: :activa,
            coincide_con: nil
end
