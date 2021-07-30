# frozen_string_literal: true

module ConnectionsHelper
  def check_customer_id
    return True if current_user&.customer_id
  end
end
