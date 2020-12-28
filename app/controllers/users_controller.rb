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
  #this routes job is to render the sign up form 
  get '/signup' do

    #erb(render) a view
    erb :signup
  end

  post '/users' do
  #where we will create a new user and persist a new user to the database
  #this will be done through params
  #"name"=>"elizabeth"
  #I only want to persist a user that has a name, email, password
  if params[:name] != "" && params[:email] != "" && params[:password] != "" #an empty string #an assumption that post request is result of the form 
  @user=User.create(params) 
  session[:user_id] = @user.id #logs the user in 
  # go to the user show page but my choice, when they sign up where do you want them to go?
  #views for a particular resource go in new folder
redirect "/users/#{:user.id}"
#the result is a brand new get request, why is this better than rendering?
# could also use erb :'/users/show' but worse
# the difference between redirect and render
#rendering should happen from a show 
else 
    #not valid input
    #would be better to include message telling them what is wrong
redirect '/signup'
end
end 
  
  #user SHOW route
  get '/users/:id' do
    @user=User.find_by(id: params[:id])
    #can either log them in or send them back to login page
    erb :'/users/show'
  "this will be the user show route"
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
  
end
