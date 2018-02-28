class CookbooksController < ApplicationController

  # view all cookbooks
  get '/cookbooks' do
    redirect_unless_logged_in
    @user = User.find_by(id: session[:id])
    @cookbooks = @user.cookbooks.all
    erb :'/cookbooks/cookbooks'
  end

  # view a specific cookbook
  get '/cookbooks/:id' do
    redirect_unless_logged_in
    @cookbook = Cookbook.find_by(id: params[:id])
    @cookbook_notes = @cookbook.notes.all
    erb :'/cookbooks/show_cookbook'
  end

  # view form to create new cookbook
  get '/cookbooks/new' do
    redirect_unless_logged_in
    erb :'/cookbooks/create_cookbook'
  end

  # post new cookbook from form to db of all cookbooks
  post '/cookbooks' do
    redirect_unless_logged_in
    @cookbook = Cookbook.create(:cookbook_name => params[:cookbook_name])
    if !params[:note_id].empty?
      @cookbook.note_id = params[:note_id]
    end
    @cookbook.user_id = current_user.id
    @cookbook.save
    redirect '/cookbooks'
  end

  # view form to edit a specific cookbook
  get '/cookbooks/:id/edit' do
    redirect_unless_logged_in
    erb :'/cookbooks/edit_cookbook'
  end

  # patch updated cookbook info from edit form to specific cookbook
  patch '/cookbooks/:id' do
    redirect_unless_logged_in
    @cookbook = Cookbook.find(params[:id])
    @cookbook.cookbook_name = params[:cookbook_name]
    if !params[:note_id].empty?
      @cookbook.note_id = params[:note_id]
    end
    @cookbook.save
    redirect '/cookbooks/cookbooks'
  end

  # delete a specific cookbook from all cookbooks
  delete '/cookbooks/:id' do
    redirect_unless_logged_in
    @cookbook = Cookbook.find(params[:id])
    if current_user.id == @cookbook.user_id
      @cookbook.delete
    end
    redirect '/cookbooks/cookbooks'
  end

end
