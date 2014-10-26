require "spec_helper"

describe Endpoints::Urls do
  include Rack::Test::Methods

  def app
    Endpoints::Urls  end

  describe "GET /urls" do
    it "succeeds" do
      get "/urls"
      last_response.status.should eq(200)
    end
  end
end
