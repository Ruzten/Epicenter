defmodule Epicenter.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_tipo, _argumentos) do
    hijos = [
      Epicenter.RegistroActividad,
      Epicenter.Usuarios,
      Epicenter.Zonas,
      Epicenter.Logistica,
      Epicenter.Comunidad,
      Epicenter.Mascotas,
      {DynamicSupervisor, name: Epicenter.SupervisorSesiones, strategy: :one_for_one}
    ]

    opciones = [strategy: :one_for_one, name: Epicenter.Supervisor]
    Supervisor.start_link(hijos, opciones)
  end
end
