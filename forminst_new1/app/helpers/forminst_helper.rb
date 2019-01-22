module ForminstHelper
    def resolve_layout
        if controller_name == "iniciotutor"
            case action_name
            when "notificaciones", "index", "planformacions"
                "ly_inicio_tutor"
            when "ver_respaldos"
                "ly_inicio_tutor_sinmenu"
            else
                "ly_inicio_tutor_adecuacion"
            end
        elsif controller_name == "informes"
            "ly_inicio_tutor_informes"
        elsif controller_name == "documents"
            "ly_inicio_tutor_sinmenu"
        end
    end
end
