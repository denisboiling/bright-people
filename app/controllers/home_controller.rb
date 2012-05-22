class HomeController < ApplicationController
  def show
    @experts = Expert.all.shuffle.take 2
  end
end
