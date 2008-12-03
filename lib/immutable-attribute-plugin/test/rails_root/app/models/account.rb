class Account < ActiveRecord::Base
  has_many :infos
  has_one :info

  ensures_immutability_of :username, :infos, :info
end
