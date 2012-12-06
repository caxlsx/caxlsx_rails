class Like < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user
end
