class NgrokHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    headers['ngrok-skip-browser-warning'] = 'true' if env['PATH_INFO'] == '/manifest.json'
    [status, headers, response]
  end
end

Rails.application.config.middleware.insert_before 0, NgrokHeader
