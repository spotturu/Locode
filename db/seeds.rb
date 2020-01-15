# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Locode.delete_all
SubDivision.delete_all

require 'csv'

#Subdivision list
filename = 'subdivision.csv'
        CSV.foreach(filename) do |row|
           s = SubDivision.new
           s.import_record(row)
        end


#Add new files in the list 
file_name_list = ['cargo_part1.csv']

file_name_list.each do |file|
	CSV.foreach(file) do |row|
           location = Locode.new 
	   location.import_record(row)
	end
end
