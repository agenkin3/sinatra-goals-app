class User < ActiveRecord::Base
  has_secure_password
  #writes method authenticate
  #we have access to this through bcrypt
  #allows us to use activerecord method authenticate
  #authenticate takes a password as a plain string
  has_many :goal_entries
end