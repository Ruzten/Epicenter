defmodule Epicenter.Mensaje do
  @moduledoc "Mensaje dirigido a una persona o familia."

  @type estado :: :pendiente | :entregado

  @type t :: %__MODULE__{
          id: String.t() | nil,
          remitente: String.t() | nil,
          destinatario: String.t() | nil,
          contenido: String.t(),
          estado: estado(),
          fecha: DateTime.t() | nil
        }

  defstruct id: nil,
            remitente: nil,
            destinatario: nil,
            contenido: "",
            estado: :pendiente,
            fecha: nil
end
