class HomeController < ApplicationController
  def show
    @experts = User.experts_for_main
  end
end
