require('pry-byebug')

class Bill

  attr_reader(:statement,:total,:package,:call_charge,:sky_store)
  def initialize (data)
    @statement = data['statement']
    @total = data['total']
    @package = data ['package']
    @call_charge = data ['callCharges']
    @sky_store = data ['skyStore']
  end

end