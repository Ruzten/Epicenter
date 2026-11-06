defmodule Epicenter.Usuario do
  @moduledoc "Usuario del sistema."

  @type rol :: :ciudadano | :voluntario | :coordinador | :administrador

  @type t :: %__MODULE__{
          nombre_usuario: String.t() | nil,
          hash_contrasena: String.t() | nil,
          sal: String.t() | nil,
          nombre_completo: String.t() | nil,
          rol: rol(),
          zona: String.t() | nil
        }

  defstruct nombre_usuario: nil,
            hash_contrasena: nil,
            sal: nil,
            nombre_completo: nil,
            rol: :ciudadano,
            zona: nil
end
