class UsersController < ApplicationController
  def authors
    @authors = User.authors_with_photos.page(params[:page]).per(12)
  end
end
