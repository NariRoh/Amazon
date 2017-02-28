require 'rails_helper'


RSpec.describe User, type: :model do

  describe 'validations' do
    # first_name must be present
    it 'requires a first_name' do
      u = FactoryGirl.build(:user, first_name: nil)
      u.valid?
      expect(u.errors).to have_key(:first_name)
    end

    # last_name must be present
    it 'requires a last_name' do
      u = FactoryGirl.build(:user, last_name: nil)
      u.valid?
      expect(u.errors).to have_key(:last_name)
    end

    # email must be unique
    it 'requires an unique email' do
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.build(:user, email: u.email )
      u1.valid?
      expect(u1.errors).to have_key(:email)
    end

    # full_name method must return first_name and last_name concatenated & titleized
    it 'requires .full_name returns first_name and last_name concatenated & titleized' do
      u = FactoryGirl.build(:user, first_name: 'nari', last_name: 'roh')
      expect(u.full_name).to eq('Nari Roh')
    end
  end
end
