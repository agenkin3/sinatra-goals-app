class UsersController < ApplicationController
  #what routes do I need for login?

  #the purpose of this route is to render the login page (form) 
get '/login' do
  erb :login
end

#what is being created here?
#action is login, method is post
#we are creating a session/adding a key value pair to the session hash
#the purpose of this route is to receive the login form
#find the user and log the user in (create a session)

post '/login' do
  #find the user
  @user = User.find_by(email: params[:email])
  #authenticate the user - verify the user is who they say they are with the right email and password combo
  if @user.authenticate(params[:password])
  #log the user in - create their session
  #redirect to the user's landing page(show? index? dashboard?)
  session[:user_id] = @user.id
  puts session
  redirect "users/#{@user.id}"
  else 
    #tell the user they entered invalid credentials
    #redirect them to the login page 
  end
end

  #what routes do I need for signup?
  get '/signup' do
    
  end

  get '/users/:id' do
  "this will be the user show route"
  end

end
