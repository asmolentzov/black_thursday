require './test/test_helper'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.new("./data/item_test.csv", "./data/merchant_test.csv", "./data/invoices.csv")

  end

  def test_it_exists
    sales = SalesEngine.new("./data/items.csv", "./data/merchants.csv", "./data/invoices.csv")
    sales_engine = SalesEngine.from_csv({items:"./data/item_test.csv", merchants:"./data/merchant_test.csv", invoices:"./data/invoices.csv"})
    assert_instance_of SalesEngine, sales
    assert_instance_of SalesEngine, sales_engine
  end

  def test_it_can_make_merchant_repo_instance
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_can_make_item_repo_instance
    assert_instance_of ItemRepository, @se.items
  end

  def test_that_merchant_repo_contains_merchants
    refute_equal 0, @se.merchants.all.size

  end

  def test_that_item_repo_contains_items
    refute_equal 1, @se.items.all
  end
end
