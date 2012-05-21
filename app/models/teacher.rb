class Teacher < ActiveRecord::Base
  attr_accessible :name, :description
  
  belongs_to :activity

  has_attached_file :teacher_photo#, :styles => {:thumb => "200x200"}
end
