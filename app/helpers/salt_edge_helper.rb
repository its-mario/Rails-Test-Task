require "json"
require "rest-client"

module SaltEdgeHelper

  APP_ID = Figaro.env.app_id
  SECRET = Figaro.env.secret 

  def salt_request(method, url, params=nil)
    response = RestClient::Request.execute(
      method:  method,
      url:     url,
      payload: params.nil? ? "" : params.to_json ,
      log:     Logger.new(STDOUT),
      headers: {                                                   
        "Accept"       => "application/json",
        "Content-type" => "application/json",
        "App-Id"       => APP_ID,
        "Secret"       => SECRET
      }
    )
    JSON.parse(response.body)
  rescue RestClient::Exception => error
    pp JSON.parse(error.response)
  end

end
