require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_one_attached(:image) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }

  describe '#for_pagination' do
    it 'returns posts ordered by created_at in ascending order' do
      older_post = create(:post, created_at: 2.days.ago)
      newer_post = create(:post, created_at: 1.day.ago)

      result = described_class.for_pagination

      expect(result).to contain_exactly(older_post, newer_post)
    end
  end
end
