defmodule EpicenterWeb.Componentes do
  @moduledoc """
  Componentes de interfaz basados en el sistema de diseño de Epicenter.

  Cada componente pinta las clases `ep-` de `priv/static/assets/epicenter.css`.
  """

  use Phoenix.Component

  @doc "Título de la pestaña: el de la pantalla seguido de Epicenter."
  def titulo(%{titulo_pagina: titulo}) when is_binary(titulo), do: "#{titulo} · Epicenter"
  def titulo(_assigns), do: "Epicenter"

  @doc "Isotipo de Epicenter. Usa `variante` \"tinta\" sobre fondos naranja."
  attr :variante, :string, default: "marca", values: ~w(marca tinta claro)
  attr :tamano, :integer, default: 40
  attr :class, :string, default: nil

  def isotipo(assigns) do
    ~H"""
    <img
      src={ruta_isotipo(@variante)}
      width={@tamano}
      height={@tamano}
      alt=""
      class={@class}
    />
    """
  end

  defp ruta_isotipo("marca"), do: "/images/epicenter-isotipo.svg"
  defp ruta_isotipo("tinta"), do: "/images/epicenter-isotipo-tinta.svg"
  defp ruta_isotipo("claro"), do: "/images/epicenter-isotipo-claro.svg"

  @doc "Muestra los mensajes flash como avisos."
  attr :flash, :map, required: true

  def avisos(assigns) do
    ~H"""
    <div :if={@flash != %{}} class="ep-avisos">
      <div
        :if={mensaje = Phoenix.Flash.get(@flash, :info)}
        class="ep-aviso ep-aviso--exito"
        role="status"
      >
        <span class="ep-aviso__marca">Listo</span>
        <span class="ep-aviso__titulo">{mensaje}</span>
      </div>
      <div
        :if={mensaje = Phoenix.Flash.get(@flash, :error)}
        class="ep-aviso ep-aviso--error"
        role="alert"
      >
        <span class="ep-aviso__marca">Error</span>
        <span class="ep-aviso__titulo">{mensaje}</span>
      </div>
    </div>
    """
  end

  @doc "Campo de formulario con rótulo, ayuda y errores."
  attr :field, Phoenix.HTML.FormField, required: true
  attr :etiqueta, :string, required: true
  attr :type, :string, default: "text"
  attr :ayuda, :string, default: nil
  attr :opciones, :list, default: []
  attr :sugerencia, :string, default: nil
  attr :rest, :global, include: ~w(autocomplete autofocus required inputmode)

  def campo(%{type: "select"} = assigns) do
    assigns = asignar_errores(assigns)

    ~H"""
    <div class="ep-campo">
      <label class="ep-campo__rotulo" for={@field.id}>{@etiqueta}</label>
      <select
        id={@field.id}
        name={@field.name}
        class="ep-campo__entrada"
        aria-invalid={@errores != [] && "true"}
        aria-describedby={descripcion(@field.id, @ayuda, @errores)}
        {@rest}
      >
        <option :if={@sugerencia} value="">{@sugerencia}</option>
        {Phoenix.HTML.Form.options_for_select(@opciones, @field.value)}
      </select>
      <span :if={@ayuda} id={"#{@field.id}-ayuda"} class="ep-campo__ayuda">{@ayuda}</span>
      <span :for={error <- @errores} id={"#{@field.id}-error"} class="ep-campo__error">{error}</span>
    </div>
    """
  end

  def campo(assigns) do
    assigns = asignar_errores(assigns)

    ~H"""
    <div class="ep-campo">
      <label class="ep-campo__rotulo" for={@field.id}>{@etiqueta}</label>
      <input
        id={@field.id}
        name={@field.name}
        type={@type}
        value={@type != "password" && Phoenix.HTML.Form.normalize_value(@type, @field.value)}
        class="ep-campo__entrada"
        aria-invalid={@errores != [] && "true"}
        aria-describedby={descripcion(@field.id, @ayuda, @errores)}
        {@rest}
      />
      <span :if={@ayuda} id={"#{@field.id}-ayuda"} class="ep-campo__ayuda">{@ayuda}</span>
      <span :for={error <- @errores} id={"#{@field.id}-error"} class="ep-campo__error">{error}</span>
    </div>
    """
  end

  defp asignar_errores(assigns) do
    assign(
      assigns,
      :errores,
      Enum.map(assigns.field.errors, fn {mensaje, _opciones} -> mensaje end)
    )
  end

  defp descripcion(id, ayuda, errores) do
    [ayuda && "#{id}-ayuda", errores != [] && "#{id}-error"]
    |> Enum.filter(& &1)
    |> Enum.join(" ")
    |> case do
      "" -> nil
      ids -> ids
    end
  end
end
