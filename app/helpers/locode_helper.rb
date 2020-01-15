module LocodeHelper
    def map_link(code_obj)
        if code_obj.coordinates.present?
            link_to("Open Maps", "https://www.google.com/maps/search/?api=1&query=#{code_obj.latitude},#{code_obj.longitude}",{target: "_blank"})
        else
            ""
        end
    end
end
