# frozen_string_literal: true

require 'transaction'

class TransactionsController < ApplicationController
  def index
    @connection_id = params['connection_id']
    @account_id = params['account_id']
    url = "https://www.saltedge.com/api/v5/transactions?connection_id=#{@connection_id}&account_id=#{@account_id}"
    api = Saltedge.new(APP_ID, SECRET, 'private.pem')
    response = api.request(:get, url)
    @transactions = response['data'].map { |hash| Transaction.new(hash) }
  end

  def show
    @connection_id = params['connection_id']
    @account_id = params['acount_id']
    transaction_id = params['id']
    url = "https://www.saltedge.com/api/v5/transactions?connection_id=#{@connection_id}&account_id=#{@account_id}"
    api = Saltedge.new(APP_ID, SECRET, 'private.pem')
    response = api.request(:get, url)
    response['data'].each do |transaction|
      @transaction = transaction if transaction['id'] == transaction_id
    end
  end
end
