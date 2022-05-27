module Middleware
  class Base
    def initialize(app)
      @app = app
    end

    def call
      raise NotImplementedError
    end
  end
end
