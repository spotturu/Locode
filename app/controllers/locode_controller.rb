class LocodeController < ApplicationController
	
	def index
		@pagy, @data_array = LocodeService.new(params).search
	end

	def autocomplete
		results = Locode.name_like(params[:q].upcase)
		render :json => results.map{|r| {id: r.id, name: [r.code,r.name].join(':')} }
	end
end
