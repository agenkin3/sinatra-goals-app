class GoalEntriesController < ApplicationController
  
  get '/goal_entries' do
    @goal_entries = GoalEntry.all
    erb :'goal_entries/index'
  end

  get '/goal_entries/new' do
    redirect_if_not_logged_in
    erb :'/goal_entries/new'
    end

    post '/goal_entries' do
        @goal_entry = GoalEntry.create(content: params[:content], user_id: current_user.id, month: params[:month], year: params[:year])
        redirect "/goal_entries/#{@goal_entry.id}"
    end

  get '/goal_entries/:id' do
    set_goal_entry
    erb :'/goal_entries/show'
  end

  get '/goal_entries/:id/edit' do
    set_goal_entry
    erb :'/goal_entries/edit'
  end

def set_goal_entry
  @goal_entry = GoalEntry.find(params[:id])
end

patch '/goal_entries/:id' do
  redirect_if_not_logged_in
  # 1. find the journal entry
  set_goal_entry
  if @goal_entry.user == current_user && params[:content] != ""
  # 2. modify (update) the journal entry
    @goal_entry.update(content: params[:content])
    # 3. redirect to show page
    redirect "/goal_entries/#{@goal_entry.id}"
  else
    redirect "users/#{current_user.id}"
  end
  end

  delete '/goal_entries/:id' do #delete action
    set_goal_entry
    @goal_entry.destroy
    redirect '/goal_entries'
  end
end

  # delete '/goal_entries/:id' do
  #   set_goal_entry
  #   if authorized_to_edit?(@goal_entry)
  #     @goal_entry.destroy
  #     flash[:message] = "Successfully deleted that entry."
  #     redirect '/goal_entries'
  #   else
  #     redirect '/goal_entries'
  #   end
  # end