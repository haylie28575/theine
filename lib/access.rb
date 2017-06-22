require "rubygems"
require "hashie"
require "httparty"

require "access/config"
require "access/much_meta"
require "access/aggregations"
require "access/api"
require "access/amt"
require "access/autocomplete"
require "access/campaign"
require "access/category"
require "access/channel"
require "access/city_savings"
require "access/device"
require "access/error"
require "access/favorite"
require "access/filter"
require "access/geolocation"
require "access/info"
require "access/link"
require "access/location"
require "access/member"
require "access/oauth_application"
require "access/offer"
require "access/organization"
require "access/product_group"
require "access/product"
require "access/program"
require "access/redeem"
require "access/redemption"
require "access/report"
require "access/request"
require "access/response"
require "access/spot"
require "access/store"
require "access/token"
require "access/user"
require "access/verify"
require "access/version"
require "access/shopping_cart"
require "access/hotel"

module Access

end

HTTParty::Response.class_eval do
  def hashify
    Hashie::Mash.new self
  end
end
