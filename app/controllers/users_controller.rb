class UsersController < ApplicationController
  def authors
    @authors = User.experts_authors.page(params[:page]).per(12)
  end
end
