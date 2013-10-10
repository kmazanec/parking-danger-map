require 'spec_helper'

describe MapsController do

  context "routing" do
    it "routes / to maps#index" do
      {:get => '/'}.should route_to({:controller => "maps", :action => "index"})

    end

  end


end
