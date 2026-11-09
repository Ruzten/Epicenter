import Config

config :epicenter_web, EpicenterWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [formats: [html: EpicenterWeb.ErrorHTML], layout: false]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
