# frozen_string_literal: true

require 'json'
require 'base64'
require 'openssl'
require 'digest'
require 'rest-client'

APP_ID = Figaro.env.app_id
SECRET = Figaro.env.secret

# copied from https://github.com/saltedge/saltedge-examples/tree/master/ruby

class Saltedge
  attr_reader :app_id, :secret, :private_key

  EXPIRATION_TIME = 60

  def self.verify_signature(public_key, data, signature)
    public_key.verify(OpenSSL::Digest.new('SHA256'), Base64.decode64(signature), data)
  end

  def initialize(app_id, secret, private_pem_path)
    @app_id      = app_id
    @secret      = secret
    @private_key = OpenSSL::PKey::RSA.new(File.open(private_pem_path))
  end

  def request(method, url, params = {})
    hash = {
      method: method,
      url: url,
      expires_at: (Time.now + EXPIRATION_TIME).to_i,
      params: as_json(params)
    }

    response = RestClient::Request.execute(
      method: hash[:method],
      url: hash[:url],
      payload: hash[:params],
      log: Logger.new($stdout),
      headers: {
        'Accept' => 'application/json',
        'Content-type' => 'application/json',
        'Expires-at' => hash[:expires_at],
        'Signature' => sign_request(hash),
        'App-Id' => app_id,
        'Secret' => secret
      }
    )
    JSON.parse(response)
  rescue RestClient::Exception => e
    pp JSON.parse(e.response)
  end

  private

  def sign_request(hash)
    data = "#{hash[:expires_at]}|#{hash[:method].to_s.upcase}|#{hash[:url]}|#{hash[:params]}"
    pp data
    Base64.encode64(private_key.sign(OpenSSL::Digest.new('SHA256'), data)).delete("\n")
  end

  def as_json(params)
    return '' if params.empty?

    params.to_json
  end
end
