class Student < ApplicationRecord
    
    has_many :registrations
    has_many :camps, through: :registrations
    belongs_to :family
    
    #validations
    
    validates_presence_of :first_name, :last_name
    validates_presence_of :family_id
    validates_numericality_of :rating, :inclusion => 0..3000, :allow_nil => true
    
    
    validate :age
    validate :name
    validate :proper_name
    validate :set_rating
    validates_date :date_of_birth, :before => lambda {Date.today}, :before_message => "can't be in the future", allow_blank: true, on: :create
    ratings = [0] + (100..3000).to_a
    validates :rating, numericality: {only_integer: true, allow_blank: true}, inclusion: {in: ratings, allow_blank: true}
    validates_numericality_of :family_id
    
    
    #scopes
    
    scope :alphabetical, -> { order('last_name, first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    
    scope :at_or_above_rating, -> (floor) { where('rating >= ?', floor) }
    scope :below_rating, -> (ceiling) { where('rating < ?', ceiling) }
    
    
    before_update :remove_registration_when_inactive
    before_save :set_rating
    
    before_destroy do
        check_if_registered_for_past_camp
        if errors.present?
            #@destroyable = false
        else
            remove_registrations
        end
    end
    
    #methods
    
    def name
        "#{self.last_name}, #{self.first_name}"
    end
  
  def proper_name
    "#{self.first_name} #{self.last_name}"
  end
  
    def age
      return nil if date_of_birth.blank?
      (Time.now.to_s(:number).to_i - date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i
    end
    
    private
    
    def set_rating
       @rating = self.rating
       if @rating == nil
           @rating = 0
       end
    end
    
    private
    
    
    def registered_for_past_camp?
        !self.registrations.select{|i| i.camp.start_date < Date.current}.empty?
    end 
    
    def check_if_registered_for_past_camp 
        registered_for_past_camp?
    end 
    
    def remove_registrations
       upcoming = self.registrations.select{|i| i.camp.start_date >= Date.current }
       upcoming.each{|j| j.destroy}
    end
    
    
    def remove_registration_when_inactive 
        remove_registrations if !self.active
    end
end
