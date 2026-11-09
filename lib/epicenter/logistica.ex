defmodule Epicenter.Logistica do
  @moduledoc """
  Necesidades, recursos, centros y movimientos en un solo proceso.

  El GenServer atiende un mensaje a la vez, así que asignar y transferir son
  operaciones atómicas.

  Responsable: Persona B. Agrega un `handle_call` por operación, encima de la
  cláusula final. Cada cambio se guarda con `Almacen.guardar/2` antes de responder.
  """

  use GenServer

  alias Epicenter.Almacen

  @archivo :logistica
  @estado_inicial %{
    necesidades: %{},
    recursos: %{},
    inventarios: %{},
    centros: %{},
    movimientos: [],
    siguiente_necesidad: 1,
    siguiente_movimiento: 1,
    siguiente_inventario: 1
  }

  @spec start_link(term()) :: GenServer.on_start()
  def start_link(_opciones), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

  @doc "Devuelve el estado completo. Útil para depurar y para pruebas."
  @spec estado() :: map()
  def estado, do: GenServer.call(__MODULE__, :estado)

  @spec registrar_necesidad(map()) :: Epicenter.resultado()
  def registrar_necesidad(datos), do: GenServer.call(__MODULE__, {:registrar_necesidad, datos})

  @spec listar_necesidades(map()) :: Epicenter.resultado()
  def listar_necesidades(filtros), do: GenServer.call(__MODULE__, {:listar_necesidades, filtros})

  @doc "Debe ordenar por prioridad con el merge sort recursivo."
  @spec necesidades_pendientes() :: Epicenter.resultado()
  def necesidades_pendientes, do: GenServer.call(__MODULE__, :necesidades_pendientes)

  @spec actualizar_necesidad(String.t(), String.t(), String.t()) :: Epicenter.resultado()
  def actualizar_necesidad(id, estado, usuario) do
    GenServer.call(__MODULE__, {:actualizar_necesidad, id, estado, usuario})
  end

  @spec cancelar_necesidad(String.t(), String.t()) :: Epicenter.resultado()
  def cancelar_necesidad(id, usuario) do
    GenServer.call(__MODULE__, {:cancelar_necesidad, id, usuario})
  end

  @spec registrar_centro(map()) :: Epicenter.resultado()
  def registrar_centro(datos), do: GenServer.call(__MODULE__, {:registrar_centro, datos})

  @spec registrar_recurso(map()) :: Epicenter.resultado()
  def registrar_recurso(datos), do: GenServer.call(__MODULE__, {:registrar_recurso, datos})

  @spec listar_recursos(map()) :: Epicenter.resultado()
  def listar_recursos(filtros), do: GenServer.call(__MODULE__, {:listar_recursos, filtros})

  @spec entrada_inventario(String.t(), String.t(), String.t(), String.t()) ::
          Epicenter.resultado()
  def entrada_inventario(codigo, ubicacion, cantidad, usuario) do
    GenServer.call(__MODULE__, {:entrada_inventario, codigo, ubicacion, cantidad, usuario})
  end

  @spec salida_inventario(String.t(), String.t(), String.t(), String.t()) ::
          Epicenter.resultado()
  def salida_inventario(codigo, ubicacion, cantidad, usuario) do
    GenServer.call(__MODULE__, {:salida_inventario, codigo, ubicacion, cantidad, usuario})
  end

  @spec historial_recurso(String.t()) :: Epicenter.resultado()
  def historial_recurso(codigo), do: GenServer.call(__MODULE__, {:historial_recurso, codigo})

  @spec transferir_recurso(String.t(), String.t(), String.t(), String.t(), String.t()) ::
          Epicenter.resultado()
  def transferir_recurso(codigo, origen, destino, cantidad, usuario) do
    GenServer.call(__MODULE__, {:transferir_recurso, codigo, origen, destino, cantidad, usuario})
  end

  @doc "Debe rechazar toda la asignación si el inventario no alcanza."
  @spec asignar_recurso(String.t(), String.t(), String.t(), String.t()) ::
          Epicenter.resultado()
  def asignar_recurso(necesidad_id, tipo, cantidad, usuario) do
    GenServer.call(__MODULE__, {:asignar_recurso, necesidad_id, tipo, cantidad, usuario})
  end

  @spec recursos_criticos() :: Epicenter.resultado()
  def recursos_criticos, do: GenServer.call(__MODULE__, :recursos_criticos)

  @impl true
  def init(:ok), do: {:ok, Almacen.cargar(@archivo, @estado_inicial)}

  @impl true
  def handle_call(:estado, _origen, estado), do: {:reply, estado, estado}

  def handle_call(_solicitud, _origen, estado) do
    {:reply, {:error, :no_implementado}, estado}
  end
end
