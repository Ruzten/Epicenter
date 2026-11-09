defmodule EpicenterWeb.ErrorHTML do
  @moduledoc "Páginas de error en texto plano."

  use EpicenterWeb, :html

  def render(plantilla, _assigns) do
    Phoenix.Controller.status_message_from_template(plantilla)
  end
end
