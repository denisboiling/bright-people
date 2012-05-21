class Teacher < ActiveRecord::Base
  attr_accessible :name, :description
  
  belongs_to :activity

  has_attached_file :photo#, :styles => {:thumb => "200x200"}
end
