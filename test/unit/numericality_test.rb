require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class NumericalityTest < Test::Unit::TestCase
  def test_simple
    build_model do
      validates_numericality_of :age, :on => :create
    end
    assert_validations_json('age' => {'numericality' => {'on' => 'create'}})
  end

  def test_only_integer
    build_model do
      validates_numericality_of :age, :only_integer => true
    end
    assert_validations_json(
      'age' => {'numericality' => {'only_integer' => true}}
    )
  end

  def test_greater_than
    build_model do
      validates_numericality_of :age, :greater_than => 17
    end
    assert_validations_json(
      'age' => {'numericality' => {'greater_than' => 17}}
    )
  end

  def test_greater_than_or_equal_to
    build_model do
      validates_numericality_of :age, :greater_than_or_equal_to => 18
    end
    assert_validations_json(
      'age' => {'numericality' => {'greater_than_or_equal_to' => 18}}
    )
  end

  def test_equal_to
    build_model do
      validates_numericality_of :age, :equal_to => 18
    end
    assert_validations_json('age' => {'numericality' => {'equal_to' => 18}})
  end

  def test_less_than
    build_model do
      validates_numericality_of :age, :less_than => 66
    end
    assert_validations_json('age' => {'numericality' => {'less_than' => 66}})
  end
  
  def test_less_than_or_equal_to
    build_model do
      validates_numericality_of :age, :less_than_or_equal_to => 65
    end
    assert_validations_json(
      'age' => {'numericality' => {'less_than_or_equal_to' => 65}}
    )
  end
  
  def test_odd
    build_model do
      validates_numericality_of :age, :odd => true
    end
    assert_validations_json('age' => {'numericality' => {'odd' => true}})
  end

  def test_even
    build_model do
      validates_numericality_of :age, :even => true
    end
    assert_validations_json('age' => {'numericality' => {'even' => true}})
  end
end

