class Registration < ApplicationRecord
    
    require 'base64'
    
    attr_accessor :credit_card_number
    attr_accessor :expiration_year
    attr_accessor :expiration_month
    
    
    belongs_to :camp
    belongs_to :student
    has_one :family, through: :student
    
    validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validate :student_is_active_in_the_system
    validate :camp_is_active_in_the_system
    
    validate :check_credit_card_number
    validate :valid_expiration_date
    validate :student_rating
    
    
    scope :alphabetical, -> { joins(:student).order('students.last_name, students.first_name') }
    scope :for_camp, ->(camp_id) { where("camp_id = ?", camp_id) }
  
    def pay
        if self.payment == nil
            self.payment = Base64.encode64("camp: #{self.camp_id}; student: #{self.student_id}; amount_paid: #{self.camp.cost}****#{self.credit_card_number[-4..-1]}")
        end
    end
    
 
 private
 
   def student_rating
     return true if self.student_id.nil? || camp_id.nil? 
     unless (student.rating).between?(camp.curriculum.min_rating, camp.curriculum.max_rating)
        errors.add(:base, "Student rating not within bounds")
     end 
   end
   
 
  def student_is_active_in_the_system
    return if self.student.nil?
      errors.add(:student, "is not currently active") if !self.student.active
  end

  def camp_is_active_in_the_system
    return if self.camp.nil?
      errors.add(:camp, "is not currently active") if !self.camp.active
  end
  
  
  #CREDIT CARD SECTION
  
  def new_credit_card
    #CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
  end 
  
  def check_credit_card_number
    return false if self.expiration_month.nil? || self.expiration_year.nil? || if self.credit_card_number.nil?
  end 
  end
  
  def valid_expiration_date
    return false if self.credit_card_number.nil? || if self.expiration_month.nil? || self.expiration_year.nil?
  end
  end

end
