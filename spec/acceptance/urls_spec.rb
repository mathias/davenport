require "spec_helper"

describe Endpoints::Urls do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  before do
    @url = Url.create

    # temporarily touch #updated_at until we can fix prmd
    @url.updated_at
    @url.save
  end

  it "GET /urls" do
    get "/urls"
    last_response.status.should eq(200)
    assert_schema_conform
  end

=begin
  it "POST /urls" do
    header "Content-Type", "application/json"
    post "/urls", MultiJson.encode({})
    last_response.status.should eq(201)
    assert_schema_conform
  end
=end

  it "GET /urls/:id" do
    get "/urls/#{@url.uuid}"
    last_response.status.should eq(200)
    assert_schema_conform
  end

  it "PATCH /urls/:id" do
    header "Content-Type", "application/json"
    patch "/urls/#{@url.uuid}", MultiJson.encode({})
    last_response.status.should eq(200)
    assert_schema_conform
  end

  it "GET /urls/:id" do
    delete "/urls/#{@url.uuid}"
    last_response.status.should eq(200)
    assert_schema_conform
  end
end
