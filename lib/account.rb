class Account
  attr_reader :id, :name, :nature, :balance, :currency_code

  def initialize hash
    @id = hash['id']
    @name = hash['name']
    @nature = hash['nature']
    @balance = hash['balance']
    @currency_code = hash['currency_code']
  end
end
