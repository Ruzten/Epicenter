defmodule Epicenter.Usuarios do
  @moduledoc """
  Usuarios, credenciales y roles.

  Responsable: Persona A. Agrega un `handle_call` por operación, encima de la
  cláusula final. Cada cambio se guarda con `Almacen.guardar/2` antes de responder.
  """

  use GenServer

  alias Epicenter.Almacen

  @archivo :usuarios

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

  def handle_call(_solicitud, _origen, estado) do
    {:reply, {:error, :no_implementado}, estado}
  end
end
