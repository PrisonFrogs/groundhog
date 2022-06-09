module Jwt
  class RefreshService < ::ApplicationService
    attr_reader :refresh_token, :user

    def initialize(refresh_token:, user:)
      super()
      @refresh_token = refresh_token
      @user = user
    end

    def call
      raise Errors::MissingToken, 'refresh token is missing' unless refresh_token

      existing_refresh_token = user.refresh_tokens.fetch(
        refresh_token
      )

      raise Errors::UnAuthorizedUser, 'invalid refresh token' unless existing_refresh_token

      new_access_token, new_refresh_token, exp_at = Jwt::IssueService.call(user)
      existing_refresh_token.destroy!

      [new_access_token, new_refresh_token, exp_at]
    end
  end
end
