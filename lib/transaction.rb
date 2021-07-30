# frozen_string_literal: true

class Transaction
  attr_reader :id, :made_on, :category, :description, :amount

  def initialize(hash)
    @id = hash['id']
    @made_on = hash['made_on']
    @category = hash['category']
    @description = hash['description']
    @amount = hash['amount']
  end
end
