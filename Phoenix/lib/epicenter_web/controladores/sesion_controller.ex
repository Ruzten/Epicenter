defmodule EpicenterWeb.SesionController do
  @moduledoc """
  Ingreso y salida de usuarios.

  Llama a `Epicenter.Usuarios.conectar/4`, que registra al usuario si no existe y
  valida su contraseña si ya existe.
  """

  use EpicenterWeb, :controller

  alias Epicenter.{Usuario, Usuarios}

  @tipos [
    {"Ciudadano", "ciudadano"},
    {"Voluntario", "voluntario"},
    {"Coordinador", "coordinador"}
  ]

  def nuevo(conn, _params) do
    if get_session(conn, :usuario) do
      redirect(conn, to: ~p"/")
    else
      mostrar_formulario(conn, %{}, [])
    end
  end

  def crear(conn, %{"sesion" => params}) do
    params = limpiar(params)

    case validar(params) do
      [] -> conectar(conn, params)
      errores -> conn |> put_status(:unprocessable_entity) |> mostrar_formulario(params, errores)
    end
  end

  def crear(conn, _params), do: mostrar_formulario(conn, %{}, [])

  def eliminar(conn, _params) do
    case get_session(conn, :usuario) do
      %{nombre_usuario: nombre_usuario} -> Usuarios.desconectar(nombre_usuario)
      _ -> :ok
    end

    conn
    |> configure_session(drop: true)
    |> redirect(to: ~p"/ingresar")
  end

  defp conectar(conn, params) do
    case Usuarios.conectar(
           params["usuario"],
           params["contrasena"],
           params["tipo"],
           params["zona"]
         ) do
      {:ok, %Usuario{} = usuario} ->
        conn
        |> configure_session(renew: true)
        |> put_session(:usuario, %{
          nombre_usuario: usuario.nombre_usuario,
          nombre_completo: usuario.nombre_completo,
          rol: usuario.rol,
          zona_principal: usuario.zona_principal
        })
        |> redirect(to: ~p"/")

      {:error, motivo} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_flash(:error, mensaje_error(motivo))
        |> mostrar_formulario(Map.delete(params, "contrasena"), [])
    end
  end

  defp mostrar_formulario(conn, params, errores) do
    render(conn, :nuevo,
      form: Phoenix.Component.to_form(params, as: :sesion, errors: errores),
      tipos: @tipos,
      registro_abierto: params["tipo"] not in [nil, ""] or params["zona"] not in [nil, ""],
      titulo_pagina: "Ingresar"
    )
  end

  defp limpiar(params) do
    Map.new(params, fn
      {"contrasena", valor} -> {"contrasena", valor}
      {clave, valor} when is_binary(valor) -> {clave, normalizar(String.trim(valor))}
      par -> par
    end)
  end

  defp normalizar(""), do: nil
  defp normalizar(valor), do: valor

  defp validar(params) do
    [
      params["usuario"] in [nil, ""] && {:usuario, {"Escribe tu usuario.", []}},
      params["contrasena"] in [nil, ""] && {:contrasena, {"Escribe tu contraseña.", []}}
    ]
    |> Enum.filter(& &1)
  end

  defp mensaje_error(:contrasena_incorrecta),
    do: "La contraseña no coincide con la de este usuario."

  defp mensaje_error(:faltan_datos_registro),
    do: "Es tu primera vez: elige tu tipo de usuario y tu zona."

  defp mensaje_error(:tipo_invalido), do: "Elige un tipo de usuario válido."
  defp mensaje_error(:argumentos_invalidos), do: "Revisa los datos: falta alguno o no es válido."

  defp mensaje_error(:no_implementado),
    do: "El ingreso todavía no funciona: falta programar Epicenter.Usuarios.conectar/4."

  defp mensaje_error(motivo), do: "No se pudo iniciar sesión (#{inspect(motivo)})."
end
