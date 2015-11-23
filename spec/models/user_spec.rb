require 'rails_helper'
# require 'spec_helper'

describe User do
	fixtures :all

	describe "#full_name" do
	  it 'returns position or name (if position is blank)' do
	    user_with_position    = build(:user, name: 'Paul George', position: 'Forward')
	    user_without_position = build(:user, name: 'Steve Nash')

	    expect(user_with_position.full_name).to eq user_with_position.position
	    expect(user_without_position.full_name).to eq user_without_position.name
	  end
  end

  describe "#is_admin?" do
  	it 'check is user has all permissions' do
  		user_role   = roles(:user)
  		admin_role  = roles(:admin)
  		simple_user = build(:user, name: 'User', role_id: user_role.id)
  		admin       = build(:user, name: 'Admin', role_id: admin_role.id)

  		expect(simple_user.is_admin?).to be_falsy
  		expect(admin.is_admin?).to be_truthy
  	end
  end
end


