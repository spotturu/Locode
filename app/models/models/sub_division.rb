class SubDivision < ApplicationRecord
	has_many :locodes

validates :code, presence: true

        def import_record(row)
                begin
                  errors =[]
                  sub_division = SubDivision.create({
                            code: row[0],
                            name: row[1],
                            region: row[2],
                            division: row[3]
                          })
                   if sub_division.validate
                     sub_division.save
                   else
                      Rails.logger.info(sub_division.errors.messages)
                   end

                end

        end

end
