module ConnectionsHelper

  class Connection
    attr_reader :id, :customer_id, :provider_name, :status,   

    def initialize hash
      @id = hash[:id]
      @customer_id = hash[:customer_id]
      @provider_name = hash[:provider_name]
      @status = hash[:status]
    end
  end

end
