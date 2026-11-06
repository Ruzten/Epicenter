defmodule Epicenter.ComandosTest do
  use ExUnit.Case

  alias Epicenter.Comandos
  alias Epicenter.Comandos.Catalogo
  alias Epicenter.Usuario

  doctest Epicenter.Comandos.Filtros

  @ciudadano %Usuario{nombre_usuario: "ana", rol: :ciudadano}
  @coordinador %Usuario{nombre_usuario: "laura", rol: :coordinador}

  test "rechaza comandos vacíos y desconocidos" do
    assert Comandos.ejecutar([], @ciudadano) == {:error, :comando_vacio}
    assert Comandos.ejecutar(["volar"], @ciudadano) == {:error, :comando_desconocido}
  end

  test "exige una sesión activa" do
    assert Comandos.ejecutar(["pending_needs"], nil) == {:error, :sin_sesion}
  end

  test "aplica el rol mínimo" do
    comando = ["assign_resource", "N001", "agua", "30"]

    assert Comandos.ejecutar(comando, @ciudadano) == {:error, :prohibido}
    assert Comandos.ejecutar(comando, @coordinador) == {:error, :no_implementado}
  end

  test "rechaza una cantidad incorrecta de datos" do
    assert Comandos.ejecutar(["cancel_need"], @coordinador) == {:error, :argumentos_invalidos}
  end

  test "help funciona sin sesión" do
    assert {:ok, nombres} = Comandos.ejecutar(["help"], nil)
    assert "assign_resource" in nombres
  end

  test "cada comando del catálogo tiene un manejador cargado" do
    for nombre <- Catalogo.nombres() do
      assert {:ok, {_rol, manejador}} = Catalogo.buscar(nombre)
      assert Code.ensure_loaded?(manejador)
    end
  end
end
