require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class InclusionTest < Test::Unit::TestCase
  def test_in_array
    build_subclass do
      validates_inclusion_of :gender, :in => %w(f m)
    end
    assert_validations_json(
      'gender' => {'inclusion' => {'in' => ['f', 'm']}}
    )
  end

  def test_in_lambda
    # Using a lambda only became an option as of ActiveRecord 3.1
    unless ActiveRecord::VERSION::MINOR == 0
      build_subclass do
        validates_inclusion_of(
          :states, :in => lambda{ |person| STATES[person.country] }
        )
      end
      assert_validations_json({})
    end
  end
end

