require './test/test_helper'
require 'time'
class CustomerRepositoryTest < MiniTest::Test

  def setup
    @time = Time.now.to_s
    @customer_1 = Customer.new({
        :id => 1,
        :first_name => "Steve",
        :last_name => "Harness",
        :created_at => @time,
        :updated_at => @time,
      })
    @customer_2 = Customer.new({
        :id => 2,
        :first_name => "Jack",
        :last_name => "Morning",
        :created_at => @time,
        :updated_at => @time,
      })
    @customer_3 = Customer.new({
        :id => 3,
        :first_name => "Caroline",
        :last_name => "Moriarty",
        :created_at => @time,
        :updated_at => @time,
      })
    @custrepo = CustomerRepository.new([@customer_1, @customer_2, @customer_3])
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @custrepo
  end

  def test_it_can_return_all_customers
    arr = [@customer_1, @customer_2, @customer_3]
    assert_equal arr, @custrepo.all
  end

  def test_it_can_find_by_id
    assert_equal @customer_1, @custrepo.find_by_id(1)
  end

end
