require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:camps)

  # test validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive

  should allow_value(1000).for(:min_rating)
  should allow_value(100).for(:min_rating)
  should allow_value(2872).for(:min_rating)
  should allow_value(0).for(:min_rating)

  should_not allow_value(nil).for(:min_rating)
  should_not allow_value(3001).for(:min_rating)
  should_not allow_value(50).for(:min_rating)
  should_not allow_value(-1).for(:min_rating)
  should_not allow_value(500.50).for(:min_rating)
  should_not allow_value("bad").for(:min_rating)

  should allow_value(1000).for(:max_rating)
  should allow_value(100).for(:max_rating)
  should allow_value(2872).for(:max_rating)

  should_not allow_value(nil).for(:max_rating)
  should_not allow_value(3001).for(:max_rating)
  should_not allow_value(50).for(:max_rating)
  should_not allow_value(-1).for(:max_rating)
  should_not allow_value(500.50).for(:max_rating)
  should_not allow_value("bad").for(:max_rating)

    # test that max greater than min rating
  should "shows that max rating is greater than min rating" do
    bad = FactoryBot.build(:curriculum, name: "Bad curriculum", min_rating: 500, max_rating: 500)
    very_bad = FactoryBot.build(:curriculum, name: "Very bad curriculum", min_rating: 500, max_rating: 450)
    deny bad.valid?
    deny very_bad.valid?
  end

  context "Within context" do
    # create the objects I want with factories
    setup do 
      create_curriculums
    end
    
    # and provide a teardown method as well
    teardown do
      delete_curriculums
    end

    # test the scope 'alphabetical'
    should "shows that there are three curriculums in in alphabetical order" do
      assert_equal ["Endgame Principles", "Endgame Principles1", "Mastering Chess Tactics", "Mastering Chess Tactics", "Smith-Morra Gambit", "Smith-Morra-Gambit1"], Curriculum.alphabetical.all.map(&:name), "#{Curriculum.class}"
    end
    
    # test the scope 'active'
    should "shows that there are four active curriculums" do
      assert_equal 4, Curriculum.active.size
      assert_equal ["Endgame Principles", "Mastering Chess Tactics"], Curriculum.active.all.map(&:name).sort, "#{Curriculum.methods}"
    end
    
    # test the scope 'active'
    should "shows that there is two inactive curriculum" do
      assert_equal 2, Curriculum.inactive.size
      assert_equal ["Smith-Morra Gambit"], Curriculum.inactive.all.map(&:name).sort
    end

    # test the scope 'for_rating'
    should "shows that there is a working for_rating scope" do
      assert_equal 2, Curriculum.for_rating(1400).size
      assert_equal ["Mastering Chess Tactics", "Mastering Chess Tactics", "Smith-Morra Gambit", "Smith-Morra Gambit1"], Curriculum.for_rating(600).all.map(&:name).sort
    end
    
    should "deny curriculum destroys" do
      deny @endgames.destroy
    end
    
    should "check for upcoming registration when making inactive" do 
      mock = MiniTest::Mock.new
      mock.expect(:call, nil, [])
      @endgames.stub(:checking_for_upcoming_registrations, mock) do 
        @endgames.update(active: false)
      end 
      
      mock.verify
      
    end
    
    should "return true if not being deactivated" do 
      assert @smithmorra.update(active: false)
    end 
    
    should "raise error if upcoming registration exists" do 
      create_active_locations
      create_family_usernames
      create_families
      create_inactive_families
      create_students
      create_camps 
      create_registrations
      
      deny @endgames.update
      
      delete_families
      delete_family_usernames
      delete_studnets
      delete_active_locations
      delete_camps
      delete_registrations
      
    end
    
    
    
  end
end
