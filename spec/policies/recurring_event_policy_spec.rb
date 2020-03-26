require 'rails_helper'

describe SimpleEventPolicy do
  let(:author) { create :user }
  let(:not_author) { create :user }
  let(:simple_event) { create :simple_event, user: author }

  subject { described_class }

  permissions :show?, :create? do
    it 'denies access if user does not exist' do
      expect(subject).to_not permit(nil, simple_event)
    end

    it 'grants access if user exist' do
      expect(subject).to permit(author, simple_event)
    end
  end

  permissions :update?, :destroy? do
    it 'denies access if user does not exist' do
      expect(subject).to_not permit(nil, simple_event)
    end

    it 'denies access if user not event author' do
      expect(subject).to_not permit(not_author, simple_event)
    end

    it 'grants access if user exist and event author' do
      expect(subject).to permit(author, simple_event)
    end
  end
end
