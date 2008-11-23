class PasswordUpdate < ActiveRecord::Base
  tableless :columns => [
      [:email, :string],
      [:password, :string],
      [:new_password, :string]
    ]
  
  attr_accessor :password_required  
    
  validates_presence_of     :email  
  
  validates_presence_of     :password, 
                            :new_password, 
                            :new_password_confirmation, 
                              :if => :password_required?
                            
  validates_confirmation_of :new_password,
                              :if => :password_required?
  
  # Defaults to true
  def password_required?
    self.password_required.nil? ? true : self.password_required
  end
  
  def email_as_id
    raise "No email set" unless self.email
    PasswordUpdate.encode(self.email)
  end
  
  class << self 
    def find_by_id(id)
      raise "No id argument" unless id 
      p = PasswordUpdate.new(:email => decode(id))
      p.exists!(p.email_as_id)
      return p
    end
    alias_method :find, :find_by_id

    def encode( str )
      str.sub("\.", "-")
    end
  
    def decode( str )
      str.sub("-", ".")
    end
  end
  
end
