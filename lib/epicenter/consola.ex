defmodule Epicenter.Consola do
  @moduledoc """
  Interfaz de comandos. La lista está en `docs/comandos.md`.

  Responsable: Persona A. Debe leer cada línea, usar `Epicenter.Analizador` y
  enviar los tokens a `Epicenter.Comandos.ejecutar/2`.
  """

  @spec iniciar() :: {:error, term()}
  def iniciar, do: {:error, :no_implementado}
end
