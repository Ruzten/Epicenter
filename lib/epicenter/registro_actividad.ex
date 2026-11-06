defmodule Epicenter.RegistroActividad do
  @moduledoc """
  Proceso independiente, creado con `spawn_link` y `receive`, que recibe la
  actividad de los usuarios.

  Responsable: Persona A. Por ahora recibe los mensajes y los descarta.
  """

  @spec start_link(term()) :: {:ok, pid()}
  def start_link(_opciones) do
    pid = spawn_link(&ciclo/0)
    Process.register(pid, __MODULE__)
    {:ok, pid}
  end

  @spec child_spec(term()) :: Supervisor.child_spec()
  def child_spec(opciones) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [opciones]}}
  end

  @spec registrar(String.t(), String.t()) :: :ok
  def registrar(nombre_usuario, accion) do
    send(__MODULE__, {:registrar, nombre_usuario, accion})
    :ok
  end

  @doc "Debe devolver la actividad registrada de un usuario."
  @spec listar(String.t()) :: Epicenter.resultado()
  def listar(_nombre_usuario), do: {:error, :no_implementado}

  defp ciclo do
    receive do
      {:registrar, _nombre_usuario, _accion} -> ciclo()
    end
  end
end
