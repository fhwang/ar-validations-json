require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class UniquenessTest < Test::Unit::TestCase
  def test_simple
    build_model do
      validates_uniqueness_of :user_name
    end
    assert_validations_json(
      'user_name' => {'uniqueness' => {'case_sensitive' => true}}
    )
  end

  def test_scope
    build_model do
      validates_uniqueness_of :user_name, :scope => :account_id
    end
    assert_validations_json(
      'user_name' => {
        'uniqueness' => {'scope' => 'account_id', 'case_sensitive' => true}
      }
    )
  end
  
  def test_scope_array
    build_model do
      validates_uniqueness_of :teacher_id, :scope => [:semester_id, :class_id]
    end
    assert_validations_json(
      'teacher_id' => {
        'uniqueness' => {
          'scope' => ['semester_id', 'class_id'], 'case_sensitive' => true
        }
      }
    )
  end

  def test_case_sensitive
    build_model do
      validates_uniqueness_of :user_name, :case_sensitive => false
    end
    assert_validations_json(
      'user_name' => {'uniqueness' => {'case_sensitive' => false}}
    )
  end
end

