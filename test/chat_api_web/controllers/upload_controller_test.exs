defmodule ChatApiWeb.UploadsControllerTest do
  use ChatApiWeb.ConnCase, async: true

  alias ChatApi.Uploads.Upload

  @create_attrs %{
    file_url: "bug_screenshot.png",
  }
  @update_attrs %{
    file_url: "updated_bug_screenshot.png",
  }
  @invalid_attrs %{filename: nil}

  setup %{conn: conn} do
    account = account_fixture()
    customer = customer_fixture(account)
    user = %ChatApi.Users.User{email: "test@example.com", account_id: account.id}
    conn = put_req_header(conn, "accept", "application/json")
    authed_conn = Pow.Plug.assign_current_user(conn, user, [])
    conversation = conversation_fixture(account, customer)
    message = message_fixture(account, conversation, %{customer_id: customer.id})
    IO.inspect("HELLO")
    IO.inspect(message)
    upload = upload_fixture(account, message)

    {:ok,
     conn: conn, authed_conn: authed_conn, account: account, upload: upload}
  end

  describe "create upload" do
    test "renders upload when data is valid", %{authed_conn: authed_conn} do
      resp =
        post(authed_conn, Routes.upload_path(authed_conn, :create),
          upload: @create_attrs
        )

      assert %{"id" => id} = json_response(resp, 201)["data"]

      # resp = get(authed_conn, Routes.event_subscription_path(authed_conn, :show, id))

      # assert %{
      #          "id" => id,
      #          "scope" => "some scope",
      #          "webhook_url" => "some webhook_url"
      #        } = json_response(resp, 200)["data"]
    end

    # test "renders errors when data is invalid", %{authed_conn: authed_conn} do
    #   resp =
    #     post(authed_conn, Routes.event_subscription_path(authed_conn, :create),
    #       event_subscription: @invalid_attrs
    #     )

    #   assert json_response(resp, 422)["errors"] != %{}
    # end
  end
end
