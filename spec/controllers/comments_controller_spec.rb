require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#create' do
    let(:user) { create(:user) }
    let(:user_post) { create(:post) }

    before { sign_in(user) }

    context 'with valid params' do
      let(:valid_params) { { comment: { body: 'Great post!' }, post_id: user_post.id } }

      it 'creates a new comment' do
        expect {
          post :create, params: valid_params
        }.to change(Comment, :count).by(1)
      end

      it 'sets the flash message' do
        post :create, params: valid_params
        expect(flash[:success]).to eq('Comment created successfully')
      end

      it 'redirects to the post page' do
        post :create, params: valid_params
        expect(response).to redirect_to(post_path(user_post))
      end
    end

    context 'with invalid comment params' do
      let(:invalid_params) { { comment: { body: '' }, post_id: user_post.id } }

      it 'does not create a new comment' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Comment, :count)
      end

      it 'renders the posts/show template' do
        post :create, params: invalid_params
        expect(response).to render_template('posts/show')
      end

      it 'returns :unprocessable entity' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
