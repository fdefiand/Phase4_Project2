class Family < ApplicationRecord
    
    has_many :students
    has_many :registrations, through: :students
    belongs_to :user
    
    #validations
    
    validates_presence_of :family_name
    validates_presence_of :parent_first_name
    
    before_destroy :delete_error
    
    #scopes
    
    scope :alphabetical, -> { order('family_name, parent_first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    
    #functions
    
    
    def make_inactive
        self.active = false
        self.save
        family_made_inactive
    end
    
    private
    
    
    def delete_error
        throw(:abort)
    end
    
    def delete_registrations
        self.registrations.select{|r| r.camp.start_date > Date.current}.each{|d| d.destroy}
    end
    
    def family_made_inactive
        if self.active == false
            delete_registrations
            self.students.update_all(active: false) 
        end
    end
    
    
end
