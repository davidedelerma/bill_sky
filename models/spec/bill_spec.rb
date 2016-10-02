require 'minitest/autorun'
require 'minitest/rg'
require_relative './bill_mock'
require_relative '../bill'

class TestBill < Minitest::Test

  def setup
    mock_data=BillMock.data
    @bill = Bill.new(mock_data)
  end

  def test_can_get_total_amount_to_pay()
    assert_equal(136.03,@bill.total)
  end

  def test_can_get_statement()
    statement={
        "generated"=>"2015-01-11", 
        "due"=>"2015-01-25", 
        "period"=>{"from"=>"2015-01-26", "to"=>"2015-02-25"}
        }
    assert_equal(statement,@bill.statement)
  end

  def test_can_get_package
    package={
        "subscriptions"=>[
          {"type"=>"tv", "name"=>"Variety with Movies HD", "cost"=>50.0}, 
          {"type"=>"talk", "name"=>"Sky Talk Anytime", "cost"=>5.0}, 
          {"type"=>"broadband", "name"=>"Fibre Unlimited", "cost"=>16.4}
        ], 
        "total"=>71.4
      }
    assert_equal(package,@bill.package)
  end
  
  def test_can_get_call_charge
    assert_equal(28,@bill.call_charge['calls'].size())
  end

  def test_can_get_skyStore
    sky_store={
      "rentals"=>[
        {"title"=>"50 Shades of Grey", "cost"=>4.99}
      ], 
      "buyAndKeep"=>[
        {"title"=>"That's what she said", "cost"=>9.99}, 
        {"title"=>"Brokeback mountain", "cost"=>9.99}
      ], 
      "total"=>24.97
    }
    assert_equal(sky_store,@bill.sky_store)
  end
end

