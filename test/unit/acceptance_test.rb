require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class AcceptanceTest < Test::Unit::TestCase
  def build_subclass(&block)
    @klass = Class.new(::ActiveRecord::Base)
    @klass.instance_eval &block
  end

  def assert_validations_json(expected)
    assert_equal(expected, JSON.parse(@klass.validations_json))
  end

  def test_simple
    build_subclass do
      validates_acceptance_of :terms_of_service
    end
    assert_validations_json({'terms_of_service' => {'acceptance' => true}})
  end

  def test_message
    build_subclass do
      validates_acceptance_of :terms_of_service, :message => 'must be abided'
    end
    assert_validations_json(
      {
        'terms_of_service' => {
          'acceptance' => {'message' => 'must be abided'}
        }
      }
    )
  end

  def test_multiple_attributes
    build_subclass do
      validates_acceptance_of :terms_of_service, :privacy_policy
    end
    assert_validations_json(
      {
        'terms_of_service' => {'acceptance' => true},
        'privacy_policy' => {'acceptance' => true}
      }
    )
  end
end
