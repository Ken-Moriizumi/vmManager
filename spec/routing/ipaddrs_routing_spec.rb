require "spec_helper"

describe IpaddrsController do
  describe "routing" do

    it "routes to #index" do
      get("/ipaddrs").should route_to("ipaddrs#index")
    end

    it "routes to #new" do
      get("/ipaddrs/new").should route_to("ipaddrs#new")
    end

    it "routes to #show" do
      get("/ipaddrs/1").should route_to("ipaddrs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ipaddrs/1/edit").should route_to("ipaddrs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ipaddrs").should route_to("ipaddrs#create")
    end

    it "routes to #update" do
      put("/ipaddrs/1").should route_to("ipaddrs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ipaddrs/1").should route_to("ipaddrs#destroy", :id => "1")
    end

  end
end
