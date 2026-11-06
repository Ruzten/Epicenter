defmodule Epicenter.Persona do
  @moduledoc "Persona afectada. `historial` conserva sus cambios de estado."

  @type estado ::
          :sin_informacion
          | :reportada
          | :localizada
          | :trasladada
          | :en_albergue
          | :reunificada

  @type t :: %__MODULE__{
          id: String.t() | nil,
          documento: String.t() | nil,
          nombre: String.t() | nil,
          edad: non_neg_integer() | nil,
          zona: String.t() | nil,
          estado: estado(),
          albergue: String.t() | nil,
          historial: [{estado(), DateTime.t()}]
        }

  defstruct id: nil,
            documento: nil,
            nombre: nil,
            edad: nil,
            zona: nil,
            estado: :sin_informacion,
            albergue: nil,
            historial: []
end
