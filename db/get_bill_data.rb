require 'net/http'
require 'json'

class Get_bill_data
  def self.fetch_data()
    url = 'https://still-scrubland-9880.herokuapp.com/bill.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return JSON.parse(response)
  end
end

