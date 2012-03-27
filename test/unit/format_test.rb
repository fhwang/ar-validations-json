require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class FormatTest < Test::Unit::TestCase
  def test_with_regexp
    build_model do
      validates_format_of(
        :email,
        :with => %r/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/,
        :on => :create
      )
    end
    assert_validations_json(
      'email' => {
        'format' => {
          'with' => "(?-mix:\\A([^@\\s]+)@((?:[-a-z0-9]+\\.)+[a-z]{2,})\\Z)",
          'on' => 'create'
        }
      }
    )
  end

  def test_without_regexp
    build_model do
      validates_format_of :email, :without => /NOSPAM/
    end
    assert_validations_json(
      'email' => {'format' => {'without' => "(?-mix:NOSPAM)"}} 
    )
  end

  def test_with_lambda
    unless ActiveRecord::VERSION::MINOR == 0
      build_model do
        validates_format_of(
          :screen_name,
          :with => lambda { |person|
            if person.admin?
              %r/\A[a-z0-9][a-z0-9_\-]*\Z/
            else
              %r/\A[a-z][a-z0-9_\-]*\Z/
            end
          }
        )
      end
      assert_validations_json({})
    end
  end
end

