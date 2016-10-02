ENV['RACK_ENV'] = 'test'



require_relative '../main.rb'
require 'test/unit'
require 'rack/test'
require_relative '../db/get_bill_data'
require_relative '../models/bill'

class SkyBillTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    data = Get_bill_data.fetch_data
    @bill = Bill.new(data)
  end

  def test_home_page_says_welcome
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('WELCOME')
  end

  def test_home_page_says_latest_bill
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('Latest Bill')
  end

  def test_home_page_says_due_on_date
    get '/' 
      assert last_response.ok?
      assert last_response.body.include?('due on:')
      assert last_response.body.include?('136.03')
  end

  def test_home_page_says_bill_is_now_ready
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('Your latest bill is now ready')
  end

  def test_home_page_shows_total
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('Total: £')
    assert last_response.body.include?(@bill.total.to_s)
  end

  def test_bill_page_generated_on_and_due_on_dates_are_visible
    get '/bill'
    generated_on_date = @bill.statement['generated']
    assert last_response.ok?
    assert last_response.body.include?(generated_on_date)
    
    due_on_date = @bill.statement["due"]
    assert last_response.body.include?(due_on_date)
  end

  def test_bill_page_from_and_to_dates_are_visible
    get '/bill'
    from_date = @bill.statement["period"]["from"]
    assert last_response.ok?
    assert last_response.body.include?(from_date)
    to_date = @bill.statement["period"]["to"]
    assert last_response.body.include?(to_date)
  end

  def test_bill_page_grand_total_is_visible
    get '/bill'
    grand_total = @bill.total
    assert last_response.ok?
    assert last_response.body.include?(grand_total.to_s)  
  end

  def test_bill_page_package_subscriptions_names_and_charges_are_visible
    get '/bill'
    assert last_response.ok?
    @bill.package['subscriptions'].each do |subscription|
      assert last_response.body.include?(subscription["name"])  
      assert last_response.body.include?(@bill.statement["period"]["from"])  
      assert last_response.body.include?(@bill.statement["period"]["to"])  
      assert last_response.body.include?(subscription["cost"].to_s)  
    end  
  end

  def test_bill_page_package_subscriptions_total_is_visible
    get '/bill'
    assert last_response.ok?  
    assert last_response.body.include?("Subscriptions total:")  
    assert last_response.body.include?(@bill.package["total"].to_s)  
  end

  def test_bill_page_individual_call_details_and_charges_are_visible
    get '/bill'
    assert last_response.ok?  
    @bill.call_charge["calls"].each do |call|
      assert last_response.body.include?(call["called"])  
      assert last_response.body.include?(call["duration"])  
      assert last_response.body.include?(call["cost"].to_s)  
    end
  end
  
  def test_bill_page_sky_store_rentals_charges_are_visible
    get '/bill'
    assert last_response.ok?  
    @bill.sky_store['rentals'].each do |rental|
      assert last_response.body.include?(rental["title"])  
      assert last_response.body.include?(rental["cost"].to_s)  
    end  
  end

  def test_bill_page_sky_store_buy_and_keep_titles_and_charges_are_visible 
    get '/bill'
    assert last_response.ok?
    @bill.sky_store['buyAndKeep'].each do |purchase|
      assert last_response.body.include?(purchase["title"])  
    end  
  end

  def test_bill_page_sky_store_total_charge_is_visible
    get '/bill'
    assert last_response.ok?
    sky_store_total_charge = @bill.sky_store["total"]
    assert last_response.body.include?(sky_store_total_charge.to_s)  
  end
end