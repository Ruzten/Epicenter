defmodule Epicenter.Necesidad do
  @moduledoc "Necesidad puntual de ayuda."

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
          asignado: [{String.t(), String.t(), pos_integer()}],
          zona: String.t() | nil,
          destino: destino(),
          prioridad: prioridad(),
          reportado_por: String.t() | nil,
          estado: estado()
        }

  defstruct id: nil,
            tipo: :otra,
            descripcion: "",
            cantidad: 0,
            asignado: [],
            zona: nil,
            destino: nil,
            prioridad: :media,
            reportado_por: nil,
            estado: :pendiente
end
