require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject = described_class.new(name: 'Res1', location: 'Islamabad')

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a location' do
    subject.location = nil
    expect(subject).not_to be_valid
  end

  it 'has many items' do
    items = described_class.reflect_on_association(:items)
    expect(items.macro).to eq(:has_many)
  end

  it 'has many cart_orders' do
    cart_orders = described_class.reflect_on_association(:cart_orders)
    expect(cart_orders.macro).to eq(:has_many)
  end

  before { described_class.create(name: 'Res1', location: 'Islamabad') }

  it 'is invalid if the name is not unique' do
    expect(subject).to be_invalid
  end

  context 'when name is unique' do
    it 'is valid if the name is unique' do
      subject = described_class.new(name: 'Res1', location: 'Islamabad')
      expect(subject).to be_valid
    end
  end
end
