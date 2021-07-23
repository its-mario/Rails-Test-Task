class SaltEdgeController < ApplicationController

  def create_customer
    identifier = current_user.email
    url = 'https://www.saltedge.com/api/v5/customers'
    param = { 'data' => { 'identifier' => identifier } }
    api = Saltedge.new(APP_ID, SECRET, 'private.pem')
    response = api.request(:post, url, param)
    current_user.update(customer_id: response['data']['id'])
    pp current_user.customer_id
    pp "HERE"
    redirect_to root_path
  end

end
