# patterns/app/models/user.rb
class User < ActiveRecord::Base
  validates :name, presence: :true
end
