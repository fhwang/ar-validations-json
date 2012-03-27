require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class AssociatedTest < Test::Unit::TestCase
  def test_simple
    build_model do
      validates_associated :pages
    end
    assert_validations_json('pages' => {'associated' => true})
  end

  def test_on
    build_model do
      validates_associated :pages, :on => :create
    end
    assert_validations_json('pages' => {'associated' => {'on' => 'create'}})
  end
end

