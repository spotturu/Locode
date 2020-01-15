namespace :update do
	require "down"
	require "zip"
	task download: :environment do
		puts "Starting download"
		path = "#{DATA_PATH}/#{Time.now.strftime("%Y%m%d%H%M%S%L")}"
		tempfile = Down.download(DOWNLOAD_PATH)
		puts "downloaded #{path}"
		Zip::File.open(tempfile.path) do |zipfile|
			FileUtils.mkdir_p(path) unless File.directory?(path)
			zipfile.each do |file|
				zipfile.extract(file, File.join(path, file.name))
			end
		end
	end
	task subdivision: :environment do
		hash_data = []
		latest_dir = get_latest_dir()
		if(latest_dir)
			p "Getting into #{latest_dir}"
			sub_division_codes = SubDivision.pluck(:code)
			csv_filename= getDivisionFile()
			if(csv_filename)
				p "Found #{csv_filename}"
				CSV.foreach(File.join(latest_dir,csv_filename),encoding: 'iso-8859-1:utf-8') do |csv|
					begin
						if csv[0].present? && csv[1].present? && csv[2].present? && csv[3].present?
							code = "#{csv[0]}#{csv[1]}" rescue nil
							p "Checking code #{code}"
							unless code.nil? || sub_division_codes.include?(code) 
								hash_data = {
									code: code,
									name: csv[2],
									region: csv[3]
								}
								puts "Adding to List::#{csv[2]}"
							end
						end
					rescue => exception
						p exception
						next
					end
				end
				SubDivision.create(hash_data)
			end
		end
	end
	
	task local_data: :environment do
		hash_data = []
		subdivision_data =  SubDivision.all.map{ |h| [h.code,h.id]}.to_h
		latest_dir = get_latest_dir()
		if(latest_dir)
			p "Getting into #{latest_dir}"
			csv_filenames= getLocodeFiles()
			if(csv_filenames.length>0)
				csv_filenames.each do |csvfile|
					p "Found #{csvfile}"
					CSV.foreach(File.join(latest_dir,csvfile),encoding: 'iso-8859-1:utf-8') do |csv|
						if csv[2].present? && csv[2] != ''
							begin
								code = "#{csv[1]}#{csv[5]}" rescue nil
								if(code!='')
									sub_division_id = subdivision_data[code] rescue nil
									hash_data = {
										code: code,
										name: csv[3],
										name_diacritics: csv[4],
										status: csv[5],
										function: csv[6],
										sub_division_id: sub_division_id,
										date: csv[8],
										iata: csv[9],
										coordinates: csv[10],
										remark: csv[11]
									}
									p "checking code #{code}"
									unless Locode.find_by(code: hash_data[:code])
										locode = Locode.create(hash_data) 
										unless locode.new_record?
											p "Saved Location #{locode.code}"
										end
									end
								end
							rescue => e  
								p e
								next
							end
						end
					end
				end
			end
		end
	end
	
	def getDivisionFile()
		csv_filename = nil
		dir = get_latest_dir
		if dir
			Dir.chdir(dir)
			csv_filename = Dir.glob('*.csv').select{|f| f.match(/SubdivisionCode/) } rescue nil
		end
		csv_filename
	end
	
	def getLocodeFiles()
		csv_filenames = []
		dir = get_latest_dir
		if dir
			Dir.chdir(dir)
			csv_filenames = Dir.glob('*.csv').select{|f| f.match(/CodeList/) } rescue []
			
		end
		csv_filenames
	end
	
	def get_latest_dir
		Dir.chdir(DATA_PATH)
		cur_folder = Dir.glob('*').select {|f| File.directory? f}.sort().max rescue nil
		File.join(DATA_PATH,cur_folder) if cur_folder
	end
end
