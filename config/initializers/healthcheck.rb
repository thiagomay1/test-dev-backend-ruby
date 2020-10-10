# frozen_string_literal: true

Healthcheck.configure do |config|
  config.success = 200
  config.error = 503
  config.verbose = false
  config.route = '/healthcheck'
  config.method = :get

  config.add_check :database,     -> { ActiveRecord::Base.connection.execute('select 1') }
  config.add_check :migrations,   -> { ActiveRecord::Migration.check_pending! }
  # -- Custom Response --
   config.custom = lambda { |controller, checker|
     controller.render json: 'Ok!' unless checker.errored?
   }
  # config.add_check :environments, -> { Dotenv.require_keys('ENV_NAME', 'ANOTHER_ENV') }
end
