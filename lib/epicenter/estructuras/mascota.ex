defmodule Epicenter.Mascota do
  @moduledoc "Reporte de mascota perdida o encontrada."

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
          zona: String.t() | nil,
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
            zona: nil,
            contacto: nil,
            estado: :activa,
            coincide_con: nil
end
