require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class AcceptanceTest < Test::Unit::TestCase
  def test_simple
    klass = Class.new(::ActiveRecord::Base) do
      validates_acceptance_of :terms_of_service
    end
    assert_equal(
      {'terms_of_service' => {'acceptance' => true}},
      JSON.parse(klass.validations_json)
    )
  end

  def test_message
    klass = Class.new(::ActiveRecord::Base) do
      validates_acceptance_of :terms_of_service, :message => 'must be abided'
    end
    assert_equal(
      {
        'terms_of_service' => {
          'acceptance' => {'message' => 'must be abided'}
        }
      },
      JSON.parse(klass.validations_json)
    )
  end

  def test_multiple_attributes
    klass = Class.new(::ActiveRecord::Base) do
      validates_acceptance_of :terms_of_service, :privacy_policy
    end
    assert_equal(
      {
        'terms_of_service' => {'acceptance' => true},
        'privacy_policy' => {'acceptance' => true}
      },
      JSON.parse(klass.validations_json)
    )
  end
end
