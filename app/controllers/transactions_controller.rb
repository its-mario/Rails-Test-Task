require 'transaction'

class TransactionsController < ApplicationController
  def index
    connection_id = params['connection_id']
    account_id = params['account_id']
    url = "https://www.saltedge.com/api/v5/transactions?connection_id=#{connection_id}&account_id=#{account_id}"
    response = helpers.salt_request(:get, url)
    @transactions = response['data'].map { |hash| Transaction.new(hash) }
  end

  def show
  end
end
