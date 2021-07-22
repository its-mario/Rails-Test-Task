require 'connection_object'

class ConnectionsController < ApplicationController
  def index
    customer_id = current_user.customer_id
    url = "https://www.saltedge.com/api/v5/connections?customer_id=#{customer_id}"
    response = helpers.salt_request(:get, url)
    @connections = response['data'].map { | hash | ConnectionObject.init(hash) }
  end

  def show
  end

  def new
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
    response = helpers.salt_request(:post, url, param)
    pp response
    pp "Here"
    redirect_to response['data']['connect_url']
  end

end
