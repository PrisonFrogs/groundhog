module Api
  class AuthenticationController < ApplicationController
    def shake
      render_payload(nickname: current_user&.nickname)
    end

    def login
      email = params[:login]
      password = params[:passw]

      @user = User.find_by(email:)
      if @user&.authenticated?(password)
        render_payload(access_token: @user.to_token, exp_at: 24.hours.from_now)
      else
        render_error('fail')
      end
    end
  end
end
