class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  #writes method authenticate
  #we have access to this through bcrypt
  #allows us to use activerecord method authenticate
  #authenticate takes a password as a plain string
  has_many :goal_entries

  # def password 
  #   @password ||= Password.new(password)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password = @password
  # end
    #Password is a class provided by the bcrypt gem 
    #getter password method checks to see whether the password exists in this instance of user 
end