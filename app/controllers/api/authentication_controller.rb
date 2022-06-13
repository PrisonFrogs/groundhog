module Api
  class AuthenticationController < ApplicationController
    def shake
      render_payload(nickname: current_user&.nickname)
    end

    def login
      email = params[:email]
      password = params[:passw]

      @user = User.find_by(email:)
      if @user&.authenticated?(password)
        access_token, refresh_token, exp_at = @user.to_token
        render_payload(access_token:, exp_at:, refresh_token:)
      else
        render_error('fail')
      end
    end

    def refresh
      @refresh_token = params[:refresh_token]

      access_token, refresh_token, exp_at = ::Jwt::RefreshService.call(@refresh_token)

      render_payload(access_token:, exp_at:, refresh_token:)
    end
  end
end
