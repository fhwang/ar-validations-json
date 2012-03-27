require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class ExclusionTest < Test::Unit::TestCase
  def test_in_array
    build_model do
      validates_exclusion_of :username, :in => %w(admin superuser)
    end
    assert_validations_json(
      'username' => {'exclusion' => {'in' => ['admin', 'superuser']}}
    )
  end

  def test_in_range
    build_model do
      validates_exclusion_of :age, :in => (1..17)
    end
    assert_validations_json(
      'age' => {
        'exclusion' => {'in' => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]}
      }
    )
  end

  def test_in_lambda
    # Using a lambda only became an option as of ActiveRecord 3.1
    unless ActiveRecord::VERSION::MINOR == 0
      build_model do
        validates_exclusion_of(
          :password, :in => lambda { |p| [p.username, p.first_name] }
        )
      end
      assert_validations_json({})
    end
  end

  def test_allow_blank
    build_model do
      validates_exclusion_of :age, :allow_blank => true, :in => (1..17)
    end
    assert_validations_json(
      'age' => {
        'exclusion' => {
          'allow_blank' => true,
          'in' => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
        }
      }
    )
  end
end

