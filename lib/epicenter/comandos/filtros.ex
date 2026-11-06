defmodule Epicenter.Comandos.Filtros do
  @moduledoc """
  Convierte filtros de texto en un mapa.

      iex> Epicenter.Comandos.Filtros.analizar(["zona=centro", "prioridad=critica"])
      %{"prioridad" => "critica", "zona" => "centro"}
  """

  @spec analizar([String.t()]) :: %{String.t() => String.t()}
  def analizar(tokens) do
    for token <- tokens, [clave, valor] <- [String.split(token, "=", parts: 2)], into: %{} do
      {clave, valor}
    end
  end
end
