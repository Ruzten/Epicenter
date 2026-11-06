defmodule Epicenter.Mascotas do
  @moduledoc """
  Reportes de mascotas y coincidencias.

  Responsable: Persona C. Agrega un `handle_call` por operación, encima de la
  cláusula final. Cada cambio se guarda con `Almacen.guardar/2` antes de responder.
  """

  use GenServer

  alias Epicenter.Almacen

  @archivo :mascotas

  @spec start_link(term()) :: GenServer.on_start()
  def start_link(_opciones), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

  @doc "Devuelve el estado completo. Útil para depurar y para pruebas."
  @spec estado() :: map()
  def estado, do: GenServer.call(__MODULE__, :estado)

  @spec reportar_mascota(map()) :: Epicenter.resultado()
  def reportar_mascota(datos), do: GenServer.call(__MODULE__, {:reportar_mascota, datos})

  @spec listar_mascotas(map()) :: Epicenter.resultado()
  def listar_mascotas(filtros), do: GenServer.call(__MODULE__, {:listar_mascotas, filtros})

  @spec buscar_coincidencias() :: Epicenter.resultado()
  def buscar_coincidencias, do: GenServer.call(__MODULE__, :buscar_coincidencias)

  @doc "Debe cerrar ambos reportes o ninguno."
  @spec confirmar_coincidencia(String.t(), String.t(), String.t()) :: Epicenter.resultado()
  def confirmar_coincidencia(id_perdida, id_encontrada, usuario) do
    GenServer.call(__MODULE__, {:confirmar_coincidencia, id_perdida, id_encontrada, usuario})
  end

  @impl true
  def init(:ok), do: {:ok, Almacen.cargar(@archivo, %{reportes: %{}, siguiente_reporte: 1})}

  @impl true
  def handle_call(:estado, _origen, estado), do: {:reply, estado, estado}

  def handle_call(_solicitud, _origen, estado) do
    {:reply, {:error, :no_implementado}, estado}
  end
end
