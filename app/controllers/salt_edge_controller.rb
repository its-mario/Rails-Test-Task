class SaltEdgeController < ApplicationController
  # APP_ID = Figaro.env.app_id
  # SECRET = Figaro.env.secret

  def create_customer
    identifier = current_user.email
    url = 'https://www.saltedge.com/api/v5/customers'
    param = { 'data' => { 'identifier' => identifier } }
    response = helpers.salt_request(:post, url, param)
    current_user.update(customer_id: response['data']['id'])
    pp current_user.customer_id
    pp "HERE"
    redirect_to root_path
  end

  def create_connection
    customer_id = current_user.customer_id
    param = {
      'data' => {
        'customer_id' => customer_id,
        'consent' => {
          'scopes' => [
            'account_details',
            'transactions_details'
          ],
          'from_date' => Time.new.to_date.to_s,
        },
        'attempt' => {
          'return_to' => 'http://127.0.0.1:3000/connections'
        }
      }
    }
    url = 'https://www.saltedge.com/api/v5/connect_sessions/create'
    response = helpers.salt_request()
    redirect_to response['connect_url']
  end

end
