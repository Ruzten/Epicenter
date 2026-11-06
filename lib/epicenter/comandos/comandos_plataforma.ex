defmodule Epicenter.Comandos.ComandosPlataforma do
  @moduledoc "Comandos de usuarios y resumen. Responsable: Persona A."

  alias Epicenter.{RegistroActividad, Resumen, Usuarios}
  alias Epicenter.Comandos.Catalogo

  @spec manejar([String.t()], Epicenter.Usuario.t() | nil) :: Epicenter.resultado()
  def manejar(["connect", nombre_usuario, contrasena], _usuario) do
    Usuarios.conectar(nombre_usuario, contrasena)
  end

  def manejar(["connect", nombre_usuario, contrasena, rol, zona], _usuario) do
    Usuarios.conectar(nombre_usuario, contrasena, rol, zona)
  end

  def manejar(["disconnect"], usuario), do: Usuarios.desconectar(usuario.nombre_usuario)
  def manejar(["help"], _usuario), do: {:ok, Catalogo.nombres()}
  def manejar(["summary"], _usuario), do: Resumen.global()

  def manejar(["activity", nombre_usuario], _usuario) do
    RegistroActividad.listar(nombre_usuario)
  end

  def manejar(_tokens, _usuario), do: {:error, :argumentos_invalidos}
end
