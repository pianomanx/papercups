defmodule ChatApiWeb.ConversationView do
  use ChatApiWeb, :view

  def render("create.json", %{conversation: conversation}) do
    %{data: render_one(conversation, ConversationView, "basic.json")}
  end
end
