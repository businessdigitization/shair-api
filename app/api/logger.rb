class Logger
  def initialize(app)
    @app = app
  end

  def call(env)
    payload = {
      remote_addr: env['REMOTE_ADDR'],
      request_method: env['REQUEST_METHOD'],
      request_path: env['PATH_INFO'],
      request_query: env['QUERY_STRING'],
      x_organization: env['HTTP_X_ORGANIZATION']
    }

    ActiveSupport::Notifications.instrument 'process_action.grape', payload do
      ActiveSupport::Notifications.instrument 'start_processing.grape', payload do
        @app.call(env).tap do |response|
          if env['api.endpoint'].respond_to?(:source)
            file_path, line_number = env['api.endpoint'].source.source_location
            payload[:controller] = file_path.sub("#{Rails.root}/", '')
            payload[:action] = line_number
          end

          if env['api.endpoint'].respond_to?(:params) && env['api.endpoint'].params.respond_to?(:to_hash)
            payload[:params] = env['api.endpoint'].params.to_hash
            payload[:params].delete('route_info')
            payload[:params].delete('format')
          end

          payload[:format] = env['api.format']
          payload[:status] = response[0]
        end
      end
    end
  end
end
