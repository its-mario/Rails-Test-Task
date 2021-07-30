# frozen_string_literal: true

module ApplicationHelper
  def log_in(classa: '')
    if current_user
      link_to 'Log Out', destroy_user_session_path, 'data-method': :delete, class: classa
    else
      link_to 'Sing In', new_user_session_path, class: classa
    end
  end

  def connected(classa: '')
    if current_user&.customer_id
      link_to 'Dasbord', connections_path, class: classa
    else
      link_to 'Connect Customer Account', create_customer_path, class: classa
    end
  end
end
