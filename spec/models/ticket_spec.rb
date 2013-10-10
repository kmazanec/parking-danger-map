require 'spec_helper'


describe Ticket do

  context "validations" do
    before{ Ticket.new }

    it { should belong_to(:user) }
    it { should belong_to(:location) }

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:location_id) }
  end


end
