defmodule Epicenter.Necesidad do
  @moduledoc """
  Necesidad puntual de ayuda.

  - `codigo_zona` apunta a `Epicenter.Zona.codigo`.
  - `reportado_por` apunta a `Epicenter.Usuario.nombre_usuario`.
  - `destino` dice para quién es: una persona, una familia, un albergue o la zona.
  - `cantidad_asignada` suma las asignaciones; el detalle está en `Epicenter.Movimiento`.
  """

  @type tipo ::
          :agua
          | :alimentos
          | :medicamentos
          | :primeros_auxilios
          | :refugio
          | :transporte
          | :rescate
          | :otra

  @type prioridad :: :critica | :alta | :media | :baja
  @type estado :: :pendiente | :asignada | :en_atencion | :atendida | :cancelada
  @type destino :: {:persona | :familia | :albergue | :zona, String.t()} | nil

  @type t :: %__MODULE__{
          id: String.t() | nil,
          tipo: tipo(),
          descripcion: String.t(),
          cantidad: non_neg_integer(),
          cantidad_asignada: non_neg_integer(),
          prioridad: prioridad(),
          estado: estado(),
          codigo_zona: String.t() | nil,
          destino: destino(),
          reportado_por: String.t() | nil
        }

  defstruct id: nil,
            tipo: :otra,
            descripcion: "",
            cantidad: 0,
            cantidad_asignada: 0,
            prioridad: :media,
            estado: :pendiente,
            codigo_zona: nil,
            destino: nil,
            reportado_por: nil
end
