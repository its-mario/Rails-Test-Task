require 'account'

class AccountsController < ApplicationController
  def index
    @connection_id = params['connection_id']
    url = "https://www.saltedge.com/api/v5/accounts?connection_id=#{@connection_id}"
    response = helpers.salt_request(:get, url)
    @accounts = response['data'].map { |hash| Account.new(hash)}
  end

  def show
  end
end
