class User < ActiveRecord::Base
  attr_accessor :password , :password_confirmation
  #attr_accessible :email, :enc_passwd, :f_name, :l_name, :vendor_flag, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :f_name,  :presence => true,
                    :length => { :maximum => 50 }

  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  # Automatically create the virtual attribute 'password_confirmation'.
  validates_presence_of :password
                        # :confirmation => true,
                        # :length => { :within => 6..40 }
                        
  before_save :encrypt_password
  
  def encrypt(password)              #Static method
    Digest::SHA2.hexdigest(password)
  end
  
  def self.authenticate_password(submitted_pw , usr)
    
    user_login_pw = User.encrypt(submitted_pw)    
    user_db_pw = usr.encrypted_password
    
    #Check if submitted pwd is equal to db password
    if user_login_pw == user_db_pw 
      return "Y"
    else
      return "N"  
    end      
  end
  
  def self.login_user(email , password)
    #Get user from email    
    # binding.pry
    user = find_by_email(email)
    
    # if user == nil
      # return "N"
    # else  
      self.authenticate_password(password , user)
    # end
        
  end

  private

  def encrypt_password
    self.enc_passwd = encrypt(password)
  end
end
