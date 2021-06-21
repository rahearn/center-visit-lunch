class LunchController < ApplicationController
  def new
    data = api.centers state: "MD"
    @count = data["results"]
    @centers = data["documents"].select { |c| c["cid"].to_i > 0 && c["cid"].to_i < 100_000 }.sort_by { |c| c["name"] }
    @centers_options = @centers.map { |c| ["#{c["name"]} - #{c["addressLineOne"]}", c["cid"]] }
  end

  def create
    @center = api.centers(cid: params[:center_id])["documents"].first
    @error = api.error_response?
    @tacos = YelpApi.new.call(lat: @center["latitude"], lon: @center["longitude"])
  end

  private

  def api
    @api ||= EclkcApi.new
  end
end
