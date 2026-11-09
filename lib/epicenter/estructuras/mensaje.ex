defmodule Epicenter.Mensaje do
  @moduledoc """
  Mensaje dirigido a una persona o familia.

  - `remitente` apunta a `Epicenter.Usuario.nombre_usuario`.
  - `documento_destinatario` apunta a `Epicenter.Persona.documento`.
  """

  @type estado :: :pendiente | :entregado

  @type t :: %__MODULE__{
          id: String.t() | nil,
          remitente: String.t() | nil,
          documento_destinatario: String.t() | nil,
          contenido: String.t(),
          estado: estado(),
          fecha: DateTime.t() | nil
        }

  defstruct id: nil,
            remitente: nil,
            documento_destinatario: nil,
            contenido: "",
            estado: :pendiente,
            fecha: nil
end
