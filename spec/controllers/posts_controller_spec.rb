require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    before { get :index }

    it 'assigns all posts to @posts' do
      posts = create_list(:post, 3)
      expect(assigns(:posts).pluck(:id)).to match_array(posts.pluck(:id))
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    let(:post) { create(:post) }

    before { get :show, params: { id: post.id } }

    it 'assigns the requested post to @post' do
      expect(assigns(:post)).to eq(post)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe '#new' do
    before do
      sign_in user
      get :new
    end

    it 'assigns a new post to @post' do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    before { sign_in user }

    context 'with valid params' do
      let(:valid_params) do
        attributes_for(:post).merge(image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'image.jpg'), 'image/jpeg'))
      end

      it 'creates a new post' do
        expect do
          post :create, params: { post: valid_params }
        end.to change(Post, :count).by(1)
      end

      it 'attaches the image to the new post' do
        post :create, params: { post: valid_params }
        expect(Post.last.image).to be_attached
      end

      it 'redirects to the posts index' do
        post :create, params: { post: valid_params }
        expect(response).to redirect_to(posts_path)
      end

      it 'sets a flash message' do
        post :create, params: { post: valid_params }
        expect(flash[:success]).to eq('Post created successfully')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { attributes_for(:post, title: nil) }

      before { post :create, params: { post: invalid_params } }

      it 'does not create a new post' do
        expect do
          post :create, params: { post: invalid_params }
        end.not_to change(Post, :count)
      end

      it 're-renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'returns unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    let!(:post) { create(:post, user_id: user.id) }

    before { sign_in user }

    context 'with valid params' do
      let(:valid_params) { { title: 'New Title' } }

      before { patch :update, params: { id: post.id, post: valid_params } }

      it 'updates the requested post' do
        post.reload
        expect(post.title).to eq('New Title')
      end

      it 'redirects to the post' do
        expect(response).to redirect_to(post)
      end

      it 'sets a flash message' do
        expect(flash[:success]).to eq('Post updated successfully')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { title: nil } }

      before { patch :update, params: { id: post.id, post: invalid_params } }

      it 'does not update the requested post' do
        post.reload
        expect(post.title).not_to be_nil
      end

      it 're-renders the edit template' do
        expect(response).to render_template(:edit)
      end

      it 'returns unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not the author of the post' do
      let(:other_user) { create(:user) }

      before do
        sign_in(other_user)
        patch :update, params: { id: post.id, post: { title: 'New Title' } }
      end

      it 'does not update the requested post' do
        post.reload
        expect(post.title).not_to eq('New Title')
      end

      it 'redirects to the root page' do
        expect(response).to redirect_to(root_path)
      end

      it 'does not set a flash message' do
        expect(flash[:success]).to be_nil
      end
    end
  end
end
