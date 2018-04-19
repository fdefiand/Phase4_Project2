class Curriculum < ApplicationRecord
  # relationships
  has_many :camps

  # validations
  validates :name, presence: true
  ratings_array = [0] + (100..3000).to_a
  validates :min_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validates :max_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validate :max_rating_greater_than_min_rating
  
  before_destroy :delete_error
  before_update :checking_for_upcoming_registrations
   
  # scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }

  private
  
  def max_rating_greater_than_min_rating
    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "must be greater than the minimum rating")
    end
  end
  
  
  def delete_error
        #throw(:abort)
  end
  

  def upcoming_registrations?
    registration_amount = camps.upcoming.map{|ci| ci.registrations.count}
    registration_amount.inject(0){|i, j| i += j}.zero?
  end
  
  def checking_for_upcoming_registrations
    return true if self.active
    if upcoming_registrations?
      throw(:abort)
    end
  end
  

end
