require File.join(File.dirname(__FILE__), 'test_helper')

class TestCitizen < Citizen::Base
  attr_accessor :a, :b, :c, :d
  attr_accessible :a, :b, :c
  validates_presence_of :a

  before_save :before_save_callback
  after_save :after_save_callback

  def before_save_callback
    true
  end

  def after_save_callback
    true
  end
end

class CitizenTest < ActiveSupport::TestCase
  setup do
    @citizen = TestCitizen.new({ 
      :a => 1, 
      :b => 2, 
      :c => 3,
      :d => 4
    })
  end

  def test_create
    TestCitizen.any_instance.expects(:before_save_callback)
    TestCitizen.any_instance.expects(:after_save_callback)
    TestCitizen.any_instance.expects(:valid?)

    @citizen = TestCitizen.create({
      :a => 1, 
      :b => 2,
      :c => 3
    })
  end

  def test_attribute_assignment
    assert @citizen.save

    assert_equal 1, @citizen.a
    assert_equal 2, @citizen.b
    assert_equal 3, @citizen.c
  end

  def test_update
    @citizen.update(:a => 2)
    assert_equal 2, @citizen.a
  end

  def test_validation
    @citizen.a = nil
    assert !@citizen.save
    assert @citizen.errors[:a].length > 0
  end

  def test_callback_success
    @citizen.expects(:before_save_callback).returns(true)
    @citizen.expects(:after_save_callback)

    assert @citizen.save
  end

  def test_callback_failure
    @citizen.expects(:before_save_callback).returns(false)
    @citizen.expects(:after_save_callback).never

    @citizen.a = nil
    assert !@citizen.save
  end

  def test_mass_assignment_security
    assert_equal nil, @citizen.d    
    @citizen.d = 4
    assert_equal 4, @citizen.d
  end

  def test_persistence
    assert_equal false, @citizen.persisted?
  end

  def test_naming
    assert_equal "TestCitizen", TestCitizen.model_name
  end

  def test_serialization
    assert @citizen.to_xml
    assert @citizen.to_json
  end
end
