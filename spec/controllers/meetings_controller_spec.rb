require 'spec_helper'

describe MeetingsController do
  let(:meeting) { FactoryGirl.create(:meeting) }

  describe "#join when the meeting is not locked" do
    before(:each) do
      controller.class.skip_before_filter :restrict

      post :join, id: meeting.id
    end

    it { should respond_with(:success) }
    it { should render_template(:join) }
  end

  describe "#join when the meeting is locked" do
    context 'password is correct' do
    end
  end
end