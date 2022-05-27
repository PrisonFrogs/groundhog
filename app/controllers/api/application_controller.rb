module Api
  class ApplicationController < ::ApplicationController
    include PayloadFormater

    def current_user
      request.env['current_user']
    end

    rescue_from ActiveRecord::ActiveRecordError do |exception|
      render_error(exception.message, status: 400)
    end
  end
end
