# frozen_string_literal: true

require 'account'

class AccountsController < ApplicationController
  def index
    @connection_id = params['connection_id']
    url = "https://www.saltedge.com/api/v5/accounts?connection_id=#{@connection_id}"
    api = Saltedge.new(APP_ID, SECRET, 'private.pem')
    response = api.request(:get, url)
    @accounts = response['data'].map { |hash| Account.new(hash) }
  end

  def show
    @connection_id = params[:connection_id]
    account_id = params[:id]
    url = "https://www.saltedge.com/api/v5/accounts?connection_id=#{@connection_id}"
    api = Saltedge.new(APP_ID, SECRET, 'private.pem')
    response = api.request(:get, url)
    response['data'].each do |account|
      @account = account if account['id'] == account_id
    end
  end
end
