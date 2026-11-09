defmodule EpicenterWeb do
  @moduledoc """
  Interfaz web de Epicenter.

  Usa los módulos del núcleo (`Epicenter.Usuarios`, `Epicenter.Logistica`, …) y solo
  se encarga de mostrar pantallas y recibir formularios.
  """

  def static_paths, do: ~w(assets images favicon.ico robots.txt)

  def router do
    quote do
      use Phoenix.Router, helpers: false

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, formats: [:html]

      import Plug.Conn

      unquote(verified_routes())
    end
  end

  def html do
    quote do
      use Phoenix.Component

      import Phoenix.Controller, only: [get_csrf_token: 0]
      import EpicenterWeb.Componentes

      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: EpicenterWeb.Endpoint,
        router: EpicenterWeb.Router,
        statics: EpicenterWeb.static_paths()
    end
  end

  defmacro __using__(tipo) when is_atom(tipo) do
    apply(__MODULE__, tipo, [])
  end
end
