defmodule Epicenter.Analizador do
  @moduledoc """
  Convierte una línea en tokens respetando el texto entre comillas.

  Responsable: Persona A. Pendiente de implementar con recursión.
  """

  @spec analizar(String.t()) :: {:ok, [String.t()]} | {:error, term()}
  def analizar(_linea), do: {:error, :no_implementado}
end
