require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class LengthTest < Test::Unit::TestCase
  def test_maximum
    build_model do
      validates_length_of :first_name, :maximum => 30
    end
    assert_validations_json(
      'first_name' => {'length' => {'maximum' => 30}}
    )
  end

  def test_in_range
    build_model do
      validates_length_of :fax, :in => 7..32, :allow_nil => true
    end
    assert_validations_json(
      'fax' => {
        'length' => {'allow_nil' => true, 'maximum' => 32, 'minimum' => 7}
      }
    )
  end

  def test_too_long_and_too_short
    build_model do
      validates_length_of(
        :user_name,
        :within => 6..20, :too_long => "pick a shorter name",
        :too_short => "pick a longer name"
      )
    end
    assert_validations_json(
      'user_name' => {
        'length' => {
          'maximum' => 20, 'minimum' => 6,
          'too_long' => 'pick a shorter name',
          'too_short' => 'pick a longer name'
        }
      }
    )
  end

  def test_is
    build_model do
      validates_length_of(
        :smurf_leader,
        :is => 4,
        :wrong_length => "papa is spelled with 4 characters... don't play me."
      )
    end
    assert_validations_json(
      'smurf_leader' => {
        'length' => {
          'is' => 4,
          'wrong_length' =>
            "papa is spelled with 4 characters... don't play me."
        }
      }
    )
  end

  def test_tokenizer_lambda
    build_model do
      validates_length_of(
        :essay,
        :minimum => 100,
        :too_short => "Your essay must be at least 100 words.",
        :tokenizer => lambda { |str| str.scan(/\w+/) }
      )
    end
    assert_validations_json({})
  end
end
