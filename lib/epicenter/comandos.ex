defmodule Epicenter.Comandos do
  @moduledoc """
  Recibe los tokens de un comando, valida sesión y rol, y lo envía a su manejador.

      Epicenter.Comandos.ejecutar(["pending_needs"], usuario)

  Los comandos, sus roles y sus manejadores están en `Epicenter.Comandos.Catalogo`.
  """

  alias Epicenter.Comandos.Catalogo
  alias Epicenter.Usuario

  @spec ejecutar([String.t()], Usuario.t() | nil) :: Epicenter.resultado()
  def ejecutar([], _usuario), do: {:error, :comando_vacio}

  def ejecutar([comando | _] = tokens, usuario) do
    case Catalogo.buscar(comando) do
      :error -> {:error, :comando_desconocido}
      {:ok, {:publico, manejador}} -> manejador.manejar(tokens, usuario)
      {:ok, {_rol, _manejador}} when is_nil(usuario) -> {:error, :sin_sesion}
      {:ok, {rol, manejador}} -> autorizar(tokens, usuario, rol, manejador)
    end
  end

  defp autorizar(tokens, %Usuario{rol: rol_usuario} = usuario, rol, manejador) do
    if Catalogo.permitido?(rol_usuario, rol) do
      manejador.manejar(tokens, usuario)
    else
      {:error, :prohibido}
    end
  end
end
