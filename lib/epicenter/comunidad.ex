defmodule Epicenter.Comunidad do
  @moduledoc """
  Personas, mensajes y albergues en un solo proceso.

  Así el ingreso a un albergue y el estado de la persona cambian juntos.

  Responsable: Persona C. Agrega un `handle_call` por operación, encima de la
  cláusula final. Cada cambio se guarda con `Almacen.guardar/2` antes de responder.
  """

  use GenServer

  alias Epicenter.Almacen

  @archivo :comunidad
  @estado_inicial %{
    personas: %{},
    mensajes: [],
    albergues: %{},
    siguiente_persona: 1,
    siguiente_mensaje: 1
  }

  @spec start_link(term()) :: GenServer.on_start()
  def start_link(_opciones), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

  @doc "Devuelve el estado completo. Útil para depurar y para pruebas."
  @spec estado() :: map()
  def estado, do: GenServer.call(__MODULE__, :estado)

  @spec reportar_persona(map()) :: Epicenter.resultado()
  def reportar_persona(datos), do: GenServer.call(__MODULE__, {:reportar_persona, datos})

  @spec buscar_persona(String.t()) :: Epicenter.resultado()
  def buscar_persona(documento), do: GenServer.call(__MODULE__, {:buscar_persona, documento})

  @spec buscar_personas(map()) :: Epicenter.resultado()
  def buscar_personas(filtros), do: GenServer.call(__MODULE__, {:buscar_personas, filtros})

  @spec actualizar_persona(String.t(), String.t(), String.t()) :: Epicenter.resultado()
  def actualizar_persona(documento, estado, usuario) do
    GenServer.call(__MODULE__, {:actualizar_persona, documento, estado, usuario})
  end

  @spec enviar_mensaje_familiar(String.t(), String.t(), String.t()) :: Epicenter.resultado()
  def enviar_mensaje_familiar(documento, contenido, remitente) do
    GenServer.call(__MODULE__, {:enviar_mensaje_familiar, documento, contenido, remitente})
  end

  @spec listar_mensajes_familiares(String.t()) :: Epicenter.resultado()
  def listar_mensajes_familiares(documento) do
    GenServer.call(__MODULE__, {:listar_mensajes_familiares, documento})
  end

  @spec entregar_mensaje(String.t()) :: Epicenter.resultado()
  def entregar_mensaje(id), do: GenServer.call(__MODULE__, {:entregar_mensaje, id})

  @spec registrar_albergue(map()) :: Epicenter.resultado()
  def registrar_albergue(datos), do: GenServer.call(__MODULE__, {:registrar_albergue, datos})

  @spec consultar_albergue(String.t()) :: Epicenter.resultado()
  def consultar_albergue(codigo), do: GenServer.call(__MODULE__, {:consultar_albergue, codigo})

  @spec registrar_ingreso(String.t(), String.t(), String.t()) :: Epicenter.resultado()
  def registrar_ingreso(codigo, documento, usuario) do
    GenServer.call(__MODULE__, {:registrar_ingreso, codigo, documento, usuario})
  end

  @spec registrar_salida(String.t(), String.t(), String.t()) :: Epicenter.resultado()
  def registrar_salida(codigo, documento, usuario) do
    GenServer.call(__MODULE__, {:registrar_salida, codigo, documento, usuario})
  end

  @doc "Asocia una necesidad (`need`) o un recurso (`resource`) al albergue."
  @spec vincular_albergue(String.t(), String.t(), String.t()) :: Epicenter.resultado()
  def vincular_albergue(codigo, tipo, id) do
    GenServer.call(__MODULE__, {:vincular_albergue, codigo, tipo, id})
  end

  @spec ranking_albergues() :: Epicenter.resultado()
  def ranking_albergues, do: GenServer.call(__MODULE__, :ranking_albergues)

  @impl true
  def init(:ok), do: {:ok, Almacen.cargar(@archivo, @estado_inicial)}

  @impl true
  def handle_call(:estado, _origen, estado), do: {:reply, estado, estado}

  def handle_call(_solicitud, _origen, estado) do
    {:reply, {:error, :no_implementado}, estado}
  end
end
