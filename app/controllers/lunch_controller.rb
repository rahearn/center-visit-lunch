class LunchController < ApplicationController
  def new
    data = api.centers state: "MD"
    @count = data["results"]
    @centers = data["documents"].sort_by { |c| c["name"] }
    @centers_options = @centers.map { |c| ["#{c["name"]} - #{c["addressLineOne"]}", c["cid"]] }
  end

  def create
    @center = api.centers(cid: params[:center_id])["documents"].first
  end

  private

  def api
    @api ||= EclkcApi.new
  end
end
