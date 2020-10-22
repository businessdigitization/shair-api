module PackageService
  class Update
    attr_reader :params

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      package.update!(items_attributes)
      package
    end

    private

    def items_attributes
      items = params[:items_attributes] || []
      items << params[:new_items] if params[:new_items].present?
      params[:items_attributes] = items.flatten
      params.except(:new_items)
    end

    def package
      Package.find(params[:id])
    end
  end
end
