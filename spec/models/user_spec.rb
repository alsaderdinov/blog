require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  describe '#author_of?' do
    let(:user) { create(:user) } # Assuming you have a user factory
    let(:post) { create(:post, user_id: user.id) } # Assuming you have a post factory

    context 'when user is the author of the resource' do
      it 'returns true' do
        expect(user.author_of?(post)).to be true
      end
    end

    context 'when user is not the author of the resource' do
      let(:other_user) { create(:user) } # Assuming you have a user factory
      let(:other_post) { create(:post, user_id: other_user.id) } # Assuming you have a post factory

      it 'returns false' do
        expect(user.author_of?(other_post)).to be false
      end
    end
  end
end
