defmodule Epicenter.Usuarios do
  @moduledoc """
  Usuarios, credenciales y roles.

  Responsable: Persona A. Agrega un `handle_call` por operación, encima de la
  cláusula final. Cada cambio se guarda con `Almacen.guardar/2` antes de responder.
  """

  use GenServer

  alias Epicenter.{Almacen, RegistroActividad, Usuario}

  @archivo :usuarios
  @tipos_registrables %{
    "ciudadano" => :ciudadano,
    "voluntario" => :voluntario,
    "coordinador" => :coordinador
  }

  @spec start_link(term()) :: GenServer.on_start()
  def start_link(_opciones), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

  @doc "Devuelve el estado completo. Útil para depurar y para pruebas."
  @spec estado() :: map()
  def estado, do: GenServer.call(__MODULE__, :estado)

  @doc "Registra al usuario si no existe; si existe, valida su contraseña."
  @spec conectar(String.t(), String.t(), String.t() | nil, String.t() | nil) ::
          Epicenter.resultado()
  def conectar(nombre_usuario, contrasena, rol \\ nil, zona \\ nil) do
    GenServer.call(__MODULE__, {:conectar, nombre_usuario, contrasena, rol, zona})
  end

  @spec desconectar(String.t()) :: Epicenter.resultado()
  def desconectar(nombre_usuario) do
    GenServer.call(__MODULE__, {:desconectar, nombre_usuario})
  end

  @impl true
  def init(:ok), do: {:ok, Almacen.cargar(@archivo, %{usuarios: %{}})}

  @impl true
  def handle_call(:estado, _origen, estado), do: {:reply, estado, estado}

  def handle_call({:conectar, nombre, contrasena, rol, zona}, _origen, estado) do
    case Map.fetch(estado.usuarios, nombre) do
      {:ok, usuario} -> {:reply, validar_contrasena(usuario, contrasena), estado}
      :error -> registrar(nombre, contrasena, rol, zona, estado)
    end
  end

  def handle_call({:desconectar, nombre}, _origen, estado) do
    RegistroActividad.registrar(nombre, "disconnect")
    {:reply, {:ok, nombre}, estado}
  end

  def handle_call(_solicitud, _origen, estado) do
    {:reply, {:error, :no_implementado}, estado}
  end

  defp validar_contrasena(%Usuario{contrasena: contrasena} = usuario, contrasena) do
    RegistroActividad.registrar(usuario.nombre_usuario, "connect")
    {:ok, usuario}
  end

  defp validar_contrasena(_usuario, _contrasena), do: {:error, :contrasena_incorrecta}

  defp registrar(_nombre, _contrasena, rol, zona, estado)
       when rol in [nil, ""] or zona in [nil, ""] do
    {:reply, {:error, :faltan_datos_registro}, estado}
  end

  defp registrar(nombre, contrasena, rol, zona, estado) do
    case Map.fetch(@tipos_registrables, rol) do
      :error ->
        {:reply, {:error, :tipo_invalido}, estado}

      {:ok, rol} ->
        usuario = %Usuario{
          nombre_usuario: nombre,
          contrasena: contrasena,
          rol: rol,
          zona_principal: zona
        }

        nuevo_estado = %{estado | usuarios: Map.put(estado.usuarios, nombre, usuario)}
        :ok = Almacen.guardar(@archivo, nuevo_estado)
        RegistroActividad.registrar(nombre, "connect (registro)")
        {:reply, {:ok, usuario}, nuevo_estado}
    end
  end
end
