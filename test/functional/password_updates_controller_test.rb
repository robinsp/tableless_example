require 'test_helper'

class PasswordUpdatesControllerTest < ActionController::TestCase

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_password_update
    email = "robin@robinspainhour.com"
    post :create, :password_update => {:email => email}
    assert_not_nil assigns(:password_update)
    assert assigns(:password_update).valid?
    
    assert !assigns(:password_update).new_record? 
    assert_not_nil assigns(:password_update).id
    assert_equal email, assigns(:password_update).email

    assert_redirected_to edit_password_update_url(assigns(:password_update))
  end


  def test_should_get_edit
    get :edit, :id => "robin@robinspainhour-com"
    assert assigns(:password_update)
    assert_equal "robin@robinspainhour.com", assigns(:password_update).email
    assert_response :success
  end

  def test_should_update_password_update
    put :update, :id => "robin@robinspainhour-com", 
                 :password_update => {
                      :password => "old_pass",
                      :new_password => "new_pass",
                      :new_password_confirmation => "new_pass"}
                      
    assert assigns(:password_update)
    assert assigns(:password_update).errors.empty?
    assert_redirected_to '/'
  end
  
  def test_should_update_password_update_and_fail
    put :update, :id => "robin@robinspainhour-com", 
                 :password_update => {
                      :password => "old_pass",
                      :new_password => "new_pass",
                      :new_password_confirmation => "mismatch"}

    assert assigns(:password_update)
    assert !assigns(:password_update).errors.empty?
    assert_response :success 
  end
end
