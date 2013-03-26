require 'spec_helper'

describe MeetingsController do
  describe "#join when the meeting is not locked" do
    let(:meeting) { FactoryGirl.create(:meeting) }

    before(:each) do
      post :join, id: meeting.id
    end

    it { should respond_with(:success) }
    it { should render_template(:join) }
  end

  describe "#join when the meeting is locked" do
    let(:meeting) { FactoryGirl.create(:meeting, is_locked: true, password: "asd", password_confirmation: "asd") }

    context 'password is correct' do
      before(:each) do
        post :join, id: meeting.id, password: meeting.password
      end

      it { should respond_with(:success) }
      it { should render_template(:join) }
    end

    context 'password is incorrect' do
      before(:each) do
        post :join, id: meeting.id, password: "badpassword"
      end

      it { should respond_with(302) }
      it { should redirect_to(unauthorized_path) }
    end
  end
end