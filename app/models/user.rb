class User < ActiveRecord::Base
  attr_accessor :password , :password_confirmation
  attr_accessible :email, :enc_passwd, :f_name, :l_name, :vendor_flag, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :f_name,  :presence => true,
                    :length => { :maximum => 50 }

  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 }
end
