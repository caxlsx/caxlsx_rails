require 'acts_as_xlsx'
class User < ActiveRecord::Base
	acts_as_xlsx columns: [:id, :name, :last_name, :address, :email]
  attr_accessible :address, :email, :last_name, :name
end
