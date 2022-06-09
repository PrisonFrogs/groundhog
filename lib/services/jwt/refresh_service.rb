module Jwt
  class RefreshService < ::ApplicationService
    attr_reader :refresh_token

    def initialize(refresh_token)
      super()
      @refresh_token = refresh_token
    end

    def call
      raise Errors::MissingToken, 'refresh token is missing' unless refresh_token

      existing_refresh_token = RefreshToken.fetch(
        refresh_token
      )
      raise Errors::UnAuthorizedUser, 'invalid refresh token' if existing_refresh_token.blank?

      user = existing_refresh_token.user

      new_access_token, new_refresh_token, exp_at = Jwt::IssueService.call(user)
      existing_refresh_token.destroy!

      [new_access_token, new_refresh_token, exp_at]
    end
  end
end
