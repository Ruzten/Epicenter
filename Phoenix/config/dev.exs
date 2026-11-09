import Config

# Clave solo para desarrollo local. En producción se lee de SECRET_KEY_BASE.
config :epicenter_web, EpicenterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "15+XJPtRG7j0iiHFklJkPrqWUP+mUV/Q/RD4VwnhBjD9JcdM97WGQ0/omiEtx+tl"

config :logger, :default_formatter, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
