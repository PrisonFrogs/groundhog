module Jwt
  module Errors
    class UnAuthorizedUser < StandardError
      def initialize(message = 'unauthorized')
        super(message)
      end
    end

    class MissingToken < StandardError; end
  end
end
