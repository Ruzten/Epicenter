defmodule Epicenter.Usuario do
  @moduledoc """
  Usuario del sistema.

  Clave: `nombre_usuario`. `zona_principal` apunta a `Epicenter.Zona.codigo`.
  """

  @type rol :: :ciudadano | :voluntario | :coordinador | :administrador

  @type t :: %__MODULE__{
          nombre_usuario: String.t() | nil,
          contrasena: String.t() | nil,
          nombre_completo: String.t() | nil,
          rol: rol(),
          zona_principal: String.t() | nil
        }

  defstruct nombre_usuario: nil,
            contrasena: nil,
            nombre_completo: nil,
            rol: :ciudadano,
            zona_principal: nil
end
