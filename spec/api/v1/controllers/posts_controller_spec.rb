require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_topic) { create(:topic) }
  let(:my_post) { create(:post, topic: my_topic, user: my_user) }

  context "unauthenticated user" do
    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "PUT update returns http unauthenticated" do
      new_post = build(:post)
      put :update, topic_id: my_topic.id, id: my_post.id, post: { title: new_post.title, body: new_post.body }
      expect(response).to have_http_status(401)
    end

    it "POST create returns http unauthenticated" do
      new_user = build(:post)
      post :create, post: { title: new_post.title, body: new_post.body }
      expect(response).to have_http_status(401)
    end
  end


  context "unauthorized user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
  end
end
