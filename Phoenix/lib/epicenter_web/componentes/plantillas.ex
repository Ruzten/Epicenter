defmodule EpicenterWeb.Plantillas do
  @moduledoc "Plantilla raíz de todas las pantallas."

  use EpicenterWeb, :html

  embed_templates "plantillas/*"
end
