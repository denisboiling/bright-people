class ContestsController < ApplicationController
  def index
    @contests = Contest.scoped
  end
end
