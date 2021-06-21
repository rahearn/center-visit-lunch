class YelpApi
  BUSINESS_SEARCH_ROUTE = "/v3/businesses/search".freeze

  attr_reader :client, :response, :response_json
  def initialize
    @client = Faraday.new(
      url: "https://api.yelp.com",
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{Rails.application.credentials.yelp_api_token}"
      }
    )
  end

  def call(lat:, lon:, term: "tacos")
    @response = client.get(BUSINESS_SEARCH_ROUTE) { |req|
      req.params = req.params.merge term: term, latitude: lat, longitude: lon, limit: 1
    }
    @response_json = JSON.parse(response.body).with_indifferent_access
    Rails.logger.debug { "Yelp.call(#{lat}, #{lon}, #{term}) returned: #{@response_json.inspect}" }
    @response_json[:businesses].first
  end
end
