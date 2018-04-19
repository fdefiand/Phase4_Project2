# require needed files
require './test/sets/curriculum_contexts'
require './test/sets/instructor_contexts'
require './test/sets/camp_contexts'
require './test/sets/camp_instructor_contexts'
require './test/sets/location_contexts'

#PHASE 4

require './test/sets/family_contexts'
require './test/sets/user_contexts'
require './test/sets/student_contexts'
require './test/sets/credit_cards_contexts'
require './test/sets/registration_contexts'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::CurriculumContexts
  include Contexts::InstructorContexts
  include Contexts::CampContexts
  include Contexts::CampInstructorContexts
  include Contexts::LocationContexts
  include Contexts::FamilyContexts
  include Contexts::UserContexts
  include Contexts::StudentContexts
  include Contexts::CreditCardsContexts
  include Contexts::RegistrationContexts

  def create_cuke_contexts
    create_curriculums
    create_active_locations
    create_instructors
    create_camps
    create_camp_instructors
    create_more_curriculums
    create_more_instructors
    create_past_camps
    create_upcoming_camps
    create_more_camp_instructors
    create_users
    create_family_usernames
    create_families
    create_students
    create_valid_cards
    create_invalid_card_lengths
    create_registrations
    
    
    
  end

end