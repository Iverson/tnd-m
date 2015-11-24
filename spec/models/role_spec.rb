require 'rails_helper'

describe Role do

  describe "Ability" do

    context "when set all abilities" do
      before :all do
        super_role = create(:role, name: 'Super role', ability: {all: {manage: "1"}})
        @super_user = build(:user, name: 'User', role_id: super_role.id)

        @ability = Ability.new(@super_user)
      end

      it  "user can manage all" do
        expect(@ability.can?(:manage, :all)).to be_truthy
        expect(@ability.can?(:manage, Tender)).to be_truthy
        expect(@ability.can?(:manage, User)).to be_truthy
      end
    end

    context "when set read only ability" do
      before :all do
        read_only_role = create(:role, name: 'Read only role', ability: {all: {read: "1"}})
        @read_only_user = build(:user, name: 'Read only user', role_id: read_only_role.id)

        @ability = Ability.new(@read_only_user)
      end

      it "user can't create anything" do
        expect(@ability.can?(:create, Comment)).to be_falsy
        expect(@ability.can?(:create, Tender)).to be_falsy
      end

      it "user can't update anything" do
        expect(@ability.can?(:update, Role)).to be_falsy
        expect(@ability.can?(:update, Tender)).to be_falsy
      end

      it "user can't destroy anything" do
        expect(@ability.can?(:destroy, User)).to be_falsy
        expect(@ability.can?(:destroy, Role)).to be_falsy
      end

      it "user can read all" do
        expect(@ability.can?(:read, :all)).to be_truthy
      end
    end

    context "when set read tenders and create comments" do
      before :all do
        tender_member_role = create(:role, name: 'Tender member role', ability: {tender: {read: "1"}, comment: {create: "1"}})
        tender_member_user = build(:user, name: 'Tender member user', role_id: tender_member_role.id)

        @ability = Ability.new(tender_member_user)
      end

      it "user can read tenders" do
        expect(@ability.can?(:read, Tender)).to be_truthy
      end

      it "user can't create tenders" do
        expect(@ability.can?(:create, Tender)).to be_falsy
      end

      it "user can't read comments" do
        expect(@ability.can?(:read, Comment)).to be_falsy
      end

      it "user can create comments" do
        expect(@ability.can?(:create, Comment)).to be_truthy
      end
    end

  end

end
