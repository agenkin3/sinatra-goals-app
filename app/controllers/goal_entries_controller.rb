class GoalEntriesController < ApplicationController
  
  get '/goal_entries' do
    redirect_if_not_logged_in
    # finds all the goal entries for the current user from the 
    # database and sets the instance variable @goal_entries value
    # @goal_entries = [entry 1, entry 2, ....]
    @goal_entries = GoalEntry.where(user_id: current_user.id)
    
    erb :'goal_entries/index'
  end

  get '/goal_entries/new' do
    redirect_if_not_logged_in
    erb :'/goal_entries/new'
    end

    post '/goal_entries' do
      if params[:content] != "" && params[:month] != "" && params[:year] != "" 
        @goal_entry = current_user.goal_entries.create(params)
        redirect "/goal_entries/#{@goal_entry.id}"
      else
        flash[:errors] = "One or more of your fields is empty."
        redirect '/goal_entries/new'
      end
    end

  get '/goal_entries/:id' do
    set_goal_entry
    erb :'/goal_entries/show'
  end

  get '/goal_entries/:id/edit' do
    set_goal_entry
    if @goal_entry.user == current_user
    erb :'/goal_entries/edit'
    else 
      redirect "/goal_entries"
    end
  end

#helper
def set_goal_entry
  @goal_entry = GoalEntry.find(params[:id])
end

#update
patch '/goal_entries/:id' do
  redirect_if_not_logged_in
  # 1. find the goal entry
  set_goal_entry
  if @goal_entry.user == current_user # don't think we need this: && params[:content] != ""
    if params[:content] != "" && params[:month] != "" && params[:year] != "" 
      # 2. modify (update) the goal entry
      #@goal_entry.update(content: params[:content])
      @goal_entry.content = params[:content]
      @goal_entry.month = params[:month]
      @goal_entry.year = params[:year]
      @goal_entry.save
      # 3. redirect to goal show page
      redirect "/goal_entries/#{@goal_entry.id}"
    else
      flash[:errors] = "One or more of your fields is empty."
      redirect "/goal_entries/#{@goal_entry.id}"
    end
  else
    redirect "users/#{current_user.id}"
  end
  end

  #delete
  delete '/goal_entries/:id' do 
    set_goal_entry
    @goal_entry.destroy
    redirect '/goal_entries'
  end
end