require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class AcceptanceTest < Test::Unit::TestCase
  def test_simple
    build_subclass do
      validates_acceptance_of :terms_of_service
    end
    assert_validations_json(
      'terms_of_service' => {
        'acceptance' => {'allow_nil' => true, 'accept' => '1'}
      }
    )
  end

  def test_message
    build_subclass do
      validates_acceptance_of :terms_of_service, :message => 'must be abided'
    end
    assert_validations_json(
      'terms_of_service' => {
        'acceptance' => {
          'message' => 'must be abided', 'allow_nil' => true, 'accept' => '1'
        }
      }
    )
  end

  def test_multiple_attributes
    build_subclass do
      validates_acceptance_of :terms_of_service, :privacy_policy
    end
    assert_validations_json(
      'terms_of_service' => {
        'acceptance' => {'allow_nil' => true, 'accept' => '1'}
      },
      'privacy_policy' => {
        'acceptance' => {'allow_nil' => true, 'accept' => '1'}
      }
    )
  end

  def test_on_create
    build_subclass do
      validates_acceptance_of :terms_of_service, :on => :create
    end
    assert_validations_json(
      'terms_of_service' => {
        'acceptance' => {
          'on' => 'create', 'allow_nil' => true, 'accept' => '1'
        }
      }
    )
  end

  def test_on_update
    build_subclass do
      validates_acceptance_of :terms_of_service, :on => :update
    end
    assert_validations_json(
      'terms_of_service' => {
        'acceptance' => {
          'on' => 'update', 'allow_nil' => true, 'accept' => '1'
        }
      }
    )
  end

  def test_allow_nil
    build_subclass do
      validates_acceptance_of :terms_of_service, :allow_nil => false
    end
    assert_validations_json(
      'terms_of_service' => {
        'acceptance' => {'allow_nil' => false, 'accept' => '1'}
      }
    )
  end

  def test_accept
    build_subclass do
      validates_acceptance_of :terms_of_service, :accept => true
    end
    assert_validations_json(
      'terms_of_service' => {
        'acceptance' => {'allow_nil' => true, 'accept' => true}
      }
    )
  end
end
