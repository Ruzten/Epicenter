defmodule Epicenter.Zonas do
  @moduledoc """
  Árbol de zonas, sectores y puntos de atención.

  Responsable: Persona C. Agrega un `handle_call` por operación, encima de la
  cláusula final. Cada cambio se guarda con `Almacen.guardar/2` antes de responder.
  """

  use GenServer

  alias Epicenter.Almacen

  @archivo :zonas

  @spec start_link(term()) :: GenServer.on_start()
  def start_link(_opciones), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

  @doc "Devuelve el estado completo. Útil para depurar y para pruebas."
  @spec estado() :: map()
  def estado, do: GenServer.call(__MODULE__, :estado)

  @spec registrar_zona(map()) :: Epicenter.resultado()
  def registrar_zona(datos), do: GenServer.call(__MODULE__, {:registrar_zona, datos})

  @spec registrar_sector(String.t(), map()) :: Epicenter.resultado()
  def registrar_sector(zona, datos) do
    GenServer.call(__MODULE__, {:registrar_sector, zona, datos})
  end

  @spec registrar_punto(String.t(), map()) :: Epicenter.resultado()
  def registrar_punto(sector, datos) do
    GenServer.call(__MODULE__, {:registrar_punto, sector, datos})
  end

  @spec estado_zona(String.t()) :: Epicenter.resultado()
  def estado_zona(codigo), do: GenServer.call(__MODULE__, {:estado_zona, codigo})

  @doc "Debe acumular las estadísticas del árbol con una función recursiva."
  @spec estadisticas_zona(String.t()) :: Epicenter.resultado()
  def estadisticas_zona(codigo), do: GenServer.call(__MODULE__, {:estadisticas_zona, codigo})

  @impl true
  def init(:ok), do: {:ok, Almacen.cargar(@archivo, %{zonas: %{}})}

  @impl true
  def handle_call(:estado, _origen, estado), do: {:reply, estado, estado}

  def handle_call(_solicitud, _origen, estado) do
    {:reply, {:error, :no_implementado}, estado}
  end
end
