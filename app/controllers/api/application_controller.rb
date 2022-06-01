module Api
  class ApplicationController < ::ApplicationController
    include PayloadFormater

    def current_user
      request.env['current_user']
    end

    def require_auth
      raise JsonWebToken::UnAuthorizedUser if current_user.blank?
    end

    rescue_from ActiveRecord::ActiveRecordError do |exception|
      render_error(exception.message, status: 400)
    end

    rescue_from JsonWebToken::UnAuthorizedUser do |exception|
      render_error(exception.message, status: 403)
    end
  end
end
