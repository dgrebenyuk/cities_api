require 'rails_helper'

RSpec.describe City, type: :model do
  describe '.list' do
    before do
      5.times do
        create(:city)
      end
      City.first.touch
    end

    it 'shoult sorted by created_at' do
      created_ats = City.all.pluck(:created_at).sort
      expect(City.all.pluck(:created_at)).to_not eq created_ats
      expect(City.list.pluck(:created_at)).to eq created_ats
    end
  end

  describe '.featured' do
    before do
      5.times do
        create(:city)
      end
    end

    let(:user) { create(:user) }

    it 'shoult sorted by popularity' do
      offset = rand(City.count)
      user.cities << City.offset(offset).first
      expect(City.featured.first).to eq user.cities.first
    end
  end
end
