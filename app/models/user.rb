class User < ApplicationRecord
    
    has_secure_password
    
    
    
    validates :username, presence: true
    validates :password_digest, presence: true
    validates_inclusion_of :role, in: %w[admin instructor parent], message: "is not an accepted role"
    validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
    validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
    
    validates_length_of :password, minimum: 4, message: "must be at least 4 charas long"
    validates_presence_of :password, on: :create
    validates_confirmation_of :password, on: :create 
    
    before_save :reformat_phone
    
    private
    
    def reformat_phone
        self.phone = phone.to_s.gsub!(/[^0-9]/,"")      
    end
    
    
    
    
    
end
