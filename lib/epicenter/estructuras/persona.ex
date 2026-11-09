defmodule Epicenter.Persona do
  @moduledoc """
  Persona afectada.

  - `documento` no se repite: los mensajes y los albergues la buscan por él.
  - `codigo_zona` apunta a `Epicenter.Zona.codigo`.
  - `codigo_albergue` apunta a `Epicenter.Albergue.codigo` mientras esté en uno.
  - `historial` conserva sus cambios de estado, el más reciente primero.
  """

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
          tipo_documento: String.t() | nil,
          nombre: String.t() | nil,
          edad: non_neg_integer() | nil,
          codigo_zona: String.t() | nil,
          estado: estado(),
          codigo_albergue: String.t() | nil,
          historial: [{estado(), DateTime.t()}]
        }

  defstruct id: nil,
            documento: nil,
            tipo_documento: nil,
            nombre: nil,
            edad: nil,
            codigo_zona: nil,
            estado: :sin_informacion,
            codigo_albergue: nil,
            historial: []
end
