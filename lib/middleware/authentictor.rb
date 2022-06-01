require_relative './base'
require_relative '../autoloads/payload_formatter'

module Middleware
  class Authenticator < Base
    include PayloadFormater

    def call(env)
      status, headers, response = @app.call(env)
      authroization_header = env['HTTP_AUTHORIZATION']&.split&.last

      if authroization_header
        begin
          @decoded = JsonWebToken.decode(authroization_header)
          env['current_user'] = User.find(@decoded[:id])
          return @app.call(env)
        rescue ActiveRecord::RecordNotFound, JWT::DecodeError
          response = [get_error('invalid session', status: 403)]
          status = 403
        end
      end

      [status, headers, response]
    end

    private

    def logger
      @logger ||= Logger.new(Rails.root.join('log/auth.log'))
    end
  end
end
