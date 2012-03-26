require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class AcceptanceTest < Test::Unit::TestCase
  class User1 < ::ActiveRecord::Base
    self.table_name = 'user'

    validates_acceptance_of :terms_of_service
  end

  def test_simple
    assert_equal(
      {'terms_of_service' => {'acceptance' => true}},
      JSON.parse(User1.validations_json)
    )
  end
end
