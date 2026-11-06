defmodule Epicenter.Comandos.Catalogo do
  @moduledoc """
  Lista oficial de comandos: rol mínimo y módulo que maneja cada uno.

  Los nombres de los comandos son los sugeridos por el enunciado.
  `:publico` significa que no necesita una sesión activa.
  """

  alias Epicenter.Comandos.{ComandosComunidad, ComandosLogistica, ComandosPlataforma}

  @type rol :: Epicenter.Usuario.rol() | :publico

  @rangos %{ciudadano: 1, voluntario: 2, coordinador: 3, administrador: 4}

  @comandos %{
    "connect" => {:publico, ComandosPlataforma},
    "help" => {:publico, ComandosPlataforma},
    "disconnect" => {:ciudadano, ComandosPlataforma},
    "summary" => {:coordinador, ComandosPlataforma},
    "activity" => {:administrador, ComandosPlataforma},
    "register_need" => {:ciudadano, ComandosLogistica},
    "list_needs" => {:ciudadano, ComandosLogistica},
    "pending_needs" => {:ciudadano, ComandosLogistica},
    "list_resources" => {:ciudadano, ComandosLogistica},
    "critical_resources" => {:ciudadano, ComandosLogistica},
    "update_need" => {:coordinador, ComandosLogistica},
    "cancel_need" => {:coordinador, ComandosLogistica},
    "register_center" => {:coordinador, ComandosLogistica},
    "register_resource" => {:coordinador, ComandosLogistica},
    "stock_in" => {:coordinador, ComandosLogistica},
    "stock_out" => {:coordinador, ComandosLogistica},
    "resource_history" => {:coordinador, ComandosLogistica},
    "transfer_resource" => {:coordinador, ComandosLogistica},
    "assign_resource" => {:coordinador, ComandosLogistica},
    "zone_status" => {:ciudadano, ComandosComunidad},
    "zone_stats" => {:ciudadano, ComandosComunidad},
    "register_zone" => {:coordinador, ComandosComunidad},
    "register_sector" => {:coordinador, ComandosComunidad},
    "register_point" => {:coordinador, ComandosComunidad},
    "report_person" => {:ciudadano, ComandosComunidad},
    "find_person" => {:ciudadano, ComandosComunidad},
    "search_people" => {:ciudadano, ComandosComunidad},
    "send_family_message" => {:ciudadano, ComandosComunidad},
    "list_family_messages" => {:ciudadano, ComandosComunidad},
    "update_person" => {:voluntario, ComandosComunidad},
    "deliver_message" => {:voluntario, ComandosComunidad},
    "check_shelter" => {:ciudadano, ComandosComunidad},
    "shelter_ranking" => {:ciudadano, ComandosComunidad},
    "register_shelter" => {:coordinador, ComandosComunidad},
    "register_entry" => {:coordinador, ComandosComunidad},
    "register_exit" => {:coordinador, ComandosComunidad},
    "link_shelter" => {:coordinador, ComandosComunidad},
    "report_pet" => {:ciudadano, ComandosComunidad},
    "list_pets" => {:ciudadano, ComandosComunidad},
    "match_pets" => {:voluntario, ComandosComunidad},
    "confirm_pet_match" => {:voluntario, ComandosComunidad}
  }

  @spec buscar(String.t()) :: {:ok, {rol(), module()}} | :error
  def buscar(comando), do: Map.fetch(@comandos, comando)

  @spec nombres() :: [String.t()]
  def nombres, do: @comandos |> Map.keys() |> Enum.sort()

  @spec permitido?(Epicenter.Usuario.rol(), Epicenter.Usuario.rol()) :: boolean()
  def permitido?(rol_usuario, rol_requerido) do
    Map.fetch!(@rangos, rol_usuario) >= Map.fetch!(@rangos, rol_requerido)
  end
end
