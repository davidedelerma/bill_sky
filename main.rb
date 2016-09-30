require( 'sinatra' )
require( 'sinatra/contrib/all' ) 
require_relative('db/get_bill_data')
require_relative('models/bill')


get '/' do
  erb :home
end

get '/bill' do
  data = Get_bill_data.fetch_data
  @bill = Bill.new(data)
  erb :bill
end