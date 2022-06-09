module Api
  class ApplicationController < ::ApplicationController
    include PayloadFormater

    def current_user
      request.env['current_user']
    end

    def require_auth
      raise ::Jwt::Errors::UnAuthorizedUser if current_user.blank?
    end

    def require_ownership(resource_user_id)
      raise ::Jwt::Errors::UnAuthorizedUser if current_user.id != resource_user_id
    end

    rescue_from ActiveRecord::ActiveRecordError do |exception|
      render_error(exception.message, status: 400)
    end

    rescue_from ::Jwt::Errors::UnAuthorizedUser, ::Jwt::Errors::MissingToken do |exception|
      render_error(exception.message, status: 403)
    end
  end
end
