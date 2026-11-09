defmodule EpicenterWeb.SesionControllerTest do
  use ExUnit.Case

  import Phoenix.ConnTest

  @endpoint EpicenterWeb.Endpoint

  test "muestra el formulario de ingreso" do
    conn = get(build_conn(), "/ingresar")
    html = html_response(conn, 200)

    assert html =~ "Ingresar"
    assert html =~ ~s(name="sesion[usuario]")
    assert html =~ ~s(name="sesion[contrasena]")
    assert html =~ "/assets/epicenter.css"
  end

  test "pide usuario y contraseña antes de llamar al núcleo" do
    conn = post(build_conn(), "/ingresar", %{"sesion" => %{"usuario" => " ", "contrasena" => ""}})
    html = html_response(conn, 422)

    assert html =~ "Escribe tu usuario."
    assert html =~ "Escribe tu contraseña."
  end

  test "muestra el error que devuelve Usuarios.conectar/4 sin repetir la contraseña" do
    params = %{"sesion" => %{"usuario" => "laura", "contrasena" => "secreta123"}}
    conn = post(build_conn(), "/ingresar", params)
    html = html_response(conn, 422)

    assert html =~ "ep-aviso--error"
    assert html =~ ~s(value="laura")
    refute html =~ "secreta123"
  end

  test "la página de inicio exige una sesión" do
    conn = get(build_conn(), "/")

    assert redirected_to(conn) == "/ingresar"
  end

  test "con sesión, /ingresar redirige al inicio" do
    conn =
      build_conn()
      |> Plug.Test.init_test_session(%{
        usuario: %{
          nombre_usuario: "laura",
          nombre_completo: nil,
          rol: :coordinador,
          zona: "centro"
        }
      })
      |> get("/ingresar")

    assert redirected_to(conn) == "/"
  end

  test "con sesión, el inicio saluda al usuario" do
    conn =
      build_conn()
      |> init_test_session(%{
        usuario: %{
          nombre_usuario: "laura",
          nombre_completo: nil,
          rol: :coordinador,
          zona: "centro"
        }
      })
      |> get("/")

    assert html_response(conn, 200) =~ "Hola, laura"
  end
end
