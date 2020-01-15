module DMSConverter
    def self.convert(point)
        point_ar = point.match(/([0-9]+)([A-Z])/)
        upper_limit = ['S','N'].include?(point_ar[2]) ? 1: 2
        multiplier = ['S','W'].include?(point_ar[2]) ? -1: 1
        degrees = point_ar[1][0..upper_limit].to_f
        minutes = point_ar[1][(upper_limit+1)..(point_ar[1].length)].to_f/60;
        (degrees + minutes) * multiplier;
    end

    def self.get_coords(str)
        lat,lng = str.split(" ")
        lat_str = convert(lat)
        lng_str = convert(lng)
        [lat_str,lng_str]
    end
end