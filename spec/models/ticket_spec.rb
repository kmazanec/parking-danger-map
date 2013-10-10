require 'spec_helper'


describe Ticket do

  context "validations" do
    before{ Ticket.new }

    it { should belong_to(:user) }
    it { should belong_to(:location) }



  end


end
