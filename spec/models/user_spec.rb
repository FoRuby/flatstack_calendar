require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'associations' do
    it { should have_many(:recurring_events) }
    it { should have_many(:simple_events) }
  end

  describe 'scopes' do
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'methods' do
    describe '#author?(item)' do
      let(:author) { create(:user) }
      let(:not_author) { create(:user) }
      let(:simple_event) { create(:simple_event, user: author) }
      let(:item_without_author) { Class.new }

      context 'author' do
        subject { author }

        it { is_expected.to be_an_author(simple_event) }
        it { is_expected.to_not be_an_author(item_without_author) }
      end

      context 'not_author' do
        subject { not_author }

        it { is_expected.to_not be_an_author(simple_event) }
        it { is_expected.to_not be_an_author(item_without_author) }
      end
    end
  end
end
