defmodule EpicenterWeb.InicioController do
  @moduledoc "Pantalla temporal después de ingresar, mientras se construye el resto de la interfaz."

  use EpicenterWeb, :controller

  def inicio(conn, _params) do
    render(conn, :inicio, usuario: conn.assigns.usuario_actual, titulo_pagina: "Inicio")
  end
end
