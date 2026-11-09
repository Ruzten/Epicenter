defmodule EpicenterWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :epicenter_web

  @opciones_sesion [
    store: :cookie,
    key: "_epicenter_web_key",
    signing_salt: "7g_rRP7B",
    same_site: "Lax"
  ]

  plug Plug.Static,
    at: "/",
    from: :epicenter_web,
    gzip: false,
    only: EpicenterWeb.static_paths()

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @opciones_sesion
  plug EpicenterWeb.Router
end
