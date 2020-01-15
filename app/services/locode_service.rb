class LocodeService
    include Pagy::Backend
    attr_accessor :params, :result
    def initialize(params)
        @params = params
    end

    def search
        filter_params
        @result = Locode.joins(:sub_division).preload(:sub_division)
        apply_filter
        apply_paging
    end


    def apply_paging
        begin
            pagy(@result)
        rescue => exception
            p exception
            pagy = Pagy.new(count: result.count, page: params[:page])
            [pagy,@result[pagy.offset,pagy.items]]
        end
    end

    def code_filter
        if params[:code].present?
            @result = @result.where(code: params[:code])
        end
    end

    def name_filter
        if params[:name].present?
            @result = @result.name_like(params[:name])
        end
    end

    def origin_filter
        origin = Locode.find_by(code: params[:origin].split(":")[0])
        if origin.present?
            @result = @result.within(DEFAULT_RADIUS, :origin=> origin).where.not(id: origin.id)
        else
            @result= []
        end
    end

    def apply_filter
        if params[:origin].present?
            origin_filter
        else
            code_filter
            name_filter
        end
    end

    private
    def filter_params
        params.slice!(:origin,:page,:code,:name)
    end
end