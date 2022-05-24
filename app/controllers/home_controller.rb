class HomeController < ApplicationController
  def index
    a = 1
    b = 2
    c = 0

    c = if a > b
          a
        else
          b
        end
    render json: {xianshi: c}
    
  end
end
