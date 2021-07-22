require "test_helper"

class SaltEdgeControllerTest < ActionDispatch::IntegrationTest
  test "should get connections" do
    get salt_edge_connections_url
    assert_response :success
  end

  test "should get accounts" do
    get salt_edge_accounts_url
    assert_response :success
  end

  test "should get transactions" do
    get salt_edge_transactions_url
    assert_response :success
  end
end
