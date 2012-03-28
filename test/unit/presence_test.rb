require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class PresenceTest < Test::Unit::TestCase
  def test_simple
    build_model do
      validates_presence_of :first_name
    end
    assert_validations_json('first_name' => {'presence' => true})
  end
end

