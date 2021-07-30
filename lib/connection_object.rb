# frozen_string_literal: true

class ConnectionObject
  attr_reader :id, :customer_id, :provider_name, :status

  def self.init(hash)
    pp hash
    ConnectionObject.new(hash)
  end

  def initialize(hash)
    @id = hash['id']
    @customer_id = hash['customer_id']
    @provider_name = hash['provider_name']
    @status = hash['status']
  end
end
