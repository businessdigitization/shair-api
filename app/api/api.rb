class API < Grape::API
  use GrapeLogging::Middleware::RequestLogger,
    logger: Rails.logger.dup,
    formatter: GrapeLogging::Formatters::Json.new,
    include: [
      GrapeLogging::Loggers::FilterParameters.new,
      GrapeLogging::Loggers::Response.new,
      GrapeLogging::Loggers::RequestHeaders.new,
      GrapeLogging::Loggers::ClientEnv.new,
    ]

  PAGINATION_MAX_PER_PAGE = 300
  PAGINATION_DEFAULT_PER_PAGE = 50

  format :json

  include Grape::Kaminari
  include ExceptionHandling

  version 'v1', using: :path

  #
  # Authentication
  #
  before do
  end

  helpers do
    #
    # Strong Parameters
    #
    def permitted_params
      declared(params, include_missing: false).merge!(id: params[:id])
    end

    def resource_params
      permitted_params.except(:page, :per_page, :offset)
    end
  end

  #
  # Pagination
  #
  before do
    # grape-kaminari will always return a page header of the given per_page param
    # and not the really used (and maybe enforced) value
    if params[:per_page] && params[:per_page].to_i > PAGINATION_MAX_PER_PAGE
      params[:per_page] = PAGINATION_MAX_PER_PAGE
    end

    # grape-kaminari will not return a header with the default value of 50 if there was no
    # per_page param
    params[:per_page] ||= PAGINATION_DEFAULT_PER_PAGE
  end

  # Resources
  mount Resources::Parcels
  mount Resources::Trips
  mount Resources::Airports
  mount Resources::ParcelItemCategories
end
