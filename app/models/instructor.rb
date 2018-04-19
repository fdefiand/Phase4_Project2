class Instructor < ApplicationRecord
  # relationships
  belongs_to :user
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors

  # validations
  validates_presence_of :first_name
  validates_presence_of :last_name


  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :needs_bio, -> { where('bio IS NULL') }

  # class methods
  def self.for_camp(camp)
    # the 'instructive way'... (which I told you if you asked me for help)
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    # the easy way... 
    # camp.instructors
  end

  # callbacks
  
  before_update :if_user_is_inactive_deactivate
  after_rollback :convert_to_inactive_and_remove_future_camps
  
  
  before_destroy do 
    check_if_this_instructor_taught_past_camps
    if errors.present?
      @destroyable = false
      throw(:abort)
    else
      self.user.destroy
      
    end
  end

  # instance methods
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end

  private
  
  def if_user_is_inactive_deactivate
    if self.active == false
      self.user.active = false 
      self.user.save 
    end
  end 
  
  def check_if_this_instructor_taught_past_camps
    unless self.camps.past.empty?
      errors.add(:base, "Instructor has taught past camps")
    end 
  end
  
  def removing_future_camps
    self.camp_instructors.select{|ci| ci.camp.start_date >= Date.current}.each{|ci| ci.destroy}
  end 
  
  def delete_user
    self.user.destroy
  end 
  
  def convert_to_inactive_and_remove_future_camps
    if @destroyable == false
      removing_future_camps
      delete_user
      self.active = false 
    end 
  end


end
