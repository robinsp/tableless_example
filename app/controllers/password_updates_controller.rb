class PasswordUpdatesController < ApplicationController

  def new
    @password_update = PasswordUpdate.new
  end
  
  def edit
    @password_update = PasswordUpdate.find( params[:id] ) 
  end

  def create
    @password_update = PasswordUpdate.new(
        params[:password_update].merge(:password_required => false ) )
    
    if @password_update.save
      @password_update.exists!( @password_update.email_as_id )
      redirect_to edit_password_update_url( @password_update )
    else
      render :action => "new" 
    end
  end

  def update
    @password_update = PasswordUpdate.find(params[:id]) 
    
    if @password_update.update_attributes( params[:password_update] )
      redirect_to '/'
    else
      render :action => "edit" 
    end
  end
  
end
