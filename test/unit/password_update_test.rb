require 'test_helper'

class PasswordUpdateTest < ActiveSupport::TestCase
  def setup
    super
    
    @valid_attributes = {
      :email => "robin@robinspainhour.com",
      :password => "old_pass",
      :new_password => "new_pass",
      :new_password_confirmation => "new_pass" }
  end
  
  def test_create 
    assert PasswordUpdate.create(@valid_attributes).valid?
  end
  
  def test_find_by_id
    p = PasswordUpdate.find_by_id("robin@robinspainhour-com")
    assert_not_nil p
    assert_equal "robin@robinspainhour.com", p.email 
    assert !p.new_record?
    assert_equal "robin@robinspainhour-com",  p.id 
  end
  
  def test_validation 
    [:email, :password, :new_password, :new_password_confirmation].each do |attribute|
      assert_not_nil PasswordUpdate.create(@valid_attributes.merge(attribute => "")).errors[attribute]  
    end
    
    p = PasswordUpdate.create(:email => "robin@robinspainhour.com", 
                              :password_required => false)
    assert p.valid?

    assert !PasswordUpdate.create(@valid_attributes.merge(
        :new_password_confirmation => "mismatch") ).valid?

    assert !PasswordUpdate.create(@valid_attributes.merge(
        :new_password_confirmation => "mismatch") ).errors[:password]
    
  end
    
end
