class Contest < ActiveRecord::Base
  attr_accessible :name, :started_at, :ended_at
end
