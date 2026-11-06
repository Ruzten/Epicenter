defmodule Epicenter do
  @moduledoc """
  Sistema de coordinación y gestión de emergencias posterior a un terremoto.

  La guía del proyecto está en `README.md` y `docs/`.
  """

  @typedoc "Respuesta común de las operaciones del sistema."
  @type resultado :: {:ok, term()} | {:error, term()}
end
