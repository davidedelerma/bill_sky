require 'minitest/autorun'
require 'minitest/rg'
require_relative '../../db/get_bill_data'
require_relative './bill_mock'

class TestBill < Minitest::Test
  def test_can_get_data_from_db
    data = Get_bill_data.fetch_data
    mock_data=BillMock.data
    assert_equal(mock_data,data)
  end
end