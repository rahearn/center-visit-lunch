module LunchHelper

  def yelp_address(location)
    [
      location[:address1],
      location[:address2],
      location[:address3],
      "#{location[:city]}, #{location[:state]} #{location[:zip_code]}"
    ].select(&:present?)
  end
end
