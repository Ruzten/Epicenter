defmodule Epicenter.Sector do
  @moduledoc """
  Sector de una zona. `codigo_zona` apunta a `Epicenter.Zona.codigo`.
  """

  @type t :: %__MODULE__{
          codigo: String.t() | nil,
          codigo_zona: String.t() | nil,
          nombre: String.t() | nil,
          nivel_afectacion: Epicenter.Zona.nivel(),
          personas_afectadas: non_neg_integer(),
          puntos: [Epicenter.PuntoAtencion.t()]
        }

  defstruct codigo: nil,
            codigo_zona: nil,
            nombre: nil,
            nivel_afectacion: :bajo,
            personas_afectadas: 0,
            puntos: []
end
