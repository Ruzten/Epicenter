defmodule EpicenterWeb.Router do
  use EpicenterWeb, :router

  pipeline :navegador do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, html: {EpicenterWeb.Plantillas, :raiz}
  end

  pipeline :requiere_sesion do
    plug :requerir_sesion
  end

  scope "/", EpicenterWeb do
    pipe_through :navegador

    get "/ingresar", SesionController, :nuevo
    post "/ingresar", SesionController, :crear
    delete "/salir", SesionController, :eliminar
  end

  scope "/", EpicenterWeb do
    pipe_through [:navegador, :requiere_sesion]

    get "/", InicioController, :inicio
  end

  defp requerir_sesion(conn, _opciones) do
    case get_session(conn, :usuario) do
      nil ->
        conn
        |> redirect(to: "/ingresar")
        |> halt()

      usuario ->
        assign(conn, :usuario_actual, usuario)
    end
  end
end
