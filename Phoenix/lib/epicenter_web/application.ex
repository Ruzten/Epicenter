defmodule EpicenterWeb.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_tipo, _argumentos) do
    hijos = [EpicenterWeb.Endpoint]

    Supervisor.start_link(hijos, strategy: :one_for_one, name: EpicenterWeb.Supervisor)
  end

  @impl true
  def config_change(cambiados, _nuevos, eliminados) do
    EpicenterWeb.Endpoint.config_change(cambiados, eliminados)
    :ok
  end
end
