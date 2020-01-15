class Locode < ApplicationRecord
	acts_as_mappable :lat_column_name => :latitude,
	:lng_column_name => :longitude
	belongs_to :sub_division
	require Rails.root.join('lib','dms_converter')
	after_create :save_latlng
	scope :name_like, ->(query) do
		where("lower(name_diacritics) LIKE ?", "%#{sanitize_sql_like(query)}%").limit(15).order(:name_diacritics) 
	end
	validates 'code', presence: true

 	def import_record(row)
                begin
                  errors =[]
                  s = SubDivision.first
		  return if not s.present?
                  h =  Locode.create({
                            code: row[1],
                            city: row[2],
                            name: row[3],
                            name_diacritics: row[4],
                            remarks: row[5],
                            function: row[6],
                            status: row[7],
			    coordinates: row[10],
                            date: row[8],
			    sub_division_id: s.id
                          })
                   if h.validate
                      h.save
                   else
                      Rails.logger.info(h.errors.messages)
                   end
                end
        end

	def save_latlng
		if coordinates.present? && coordinates!=''
			coords = DMSConverter.get_coords(coordinates)
			self.latitude, self.longitude = coords
			self.save
		end
	end
end
