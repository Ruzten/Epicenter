defmodule Epicenter.Sesion do
  @moduledoc """
  Proceso de un usuario conectado, supervisado por `Epicenter.SupervisorSesiones`.

  Responsable: Persona A.
  """

  use GenServer, restart: :temporary

  @spec iniciar(String.t()) :: DynamicSupervisor.on_start_child()
  def iniciar(nombre_usuario) do
    DynamicSupervisor.start_child(Epicenter.SupervisorSesiones, {__MODULE__, nombre_usuario})
  end

  @spec start_link(String.t()) :: GenServer.on_start()
  def start_link(nombre_usuario), do: GenServer.start_link(__MODULE__, nombre_usuario)

  @impl true
  def init(nombre_usuario), do: {:ok, %{nombre_usuario: nombre_usuario}}
end
