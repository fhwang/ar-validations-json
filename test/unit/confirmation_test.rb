require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class ConfirmationTest < Test::Unit::TestCase
  def test_simple
    build_subclass do
      validates_confirmation_of :username
    end
    assert_validations_json('username' => {'confirmation' => true})
  end

  def test_on
    build_subclass do
      validates_confirmation_of :password, :on => :create
    end
    assert_validations_json(
      'password' => {'confirmation' => {'on' => 'create'}}
    )
  end
end

