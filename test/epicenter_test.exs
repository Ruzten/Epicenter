defmodule EpicenterTest do
  use ExUnit.Case

  @procesos [
    Epicenter.RegistroActividad,
    Epicenter.Usuarios,
    Epicenter.Zonas,
    Epicenter.Logistica,
    Epicenter.Comunidad,
    Epicenter.Mascotas,
    Epicenter.SupervisorSesiones
  ]

  test "todos los procesos base están vivos" do
    for nombre <- @procesos do
      assert is_pid(Process.whereis(nombre)), "#{inspect(nombre)} no está corriendo"
    end
  end

  test "una sesión arranca bajo el DynamicSupervisor" do
    assert {:ok, pid} = Epicenter.Sesion.iniciar("laura")

    assert Enum.any?(
             DynamicSupervisor.which_children(Epicenter.SupervisorSesiones),
             fn {_id, hijo, _tipo, _modulos} -> hijo == pid end
           )

    DynamicSupervisor.terminate_child(Epicenter.SupervisorSesiones, pid)
  end

  test "un albergue nuevo inicia sin ocupantes" do
    assert MapSet.size(%Epicenter.Albergue{}.ocupantes) == 0
  end
end
