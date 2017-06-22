module Access
  class Response

    #basics
    attr_reader :info, :links, :message, :status, :success, :error, :response_status, :dev_node, :internal_details, :response
    #resources
    attr_reader :offers, :stores, :locations, :categories, :suggestions, :oauth_applications, :access_tokens, :oauth_tokens, :oauth_token, :verify, :reports, :members, :filters, :oauth_access_token, :users, :offer_redemptions, :favorites, :campaigns, :channels, :spots, :programs, :devices, :product_groups, :products
    #aggregations
    attr_reader :offer_count_in_categories, :offer_count_by_redemption_method, :offer_count_by_facet, :custom_aggregation
    #redemptions
    attr_reader :content_type, :redemption_method, :details
    #usages
    attr_reader :api_calls_over_time, :member_usage
    #campaign show page
    attr_reader :key, :campaign_name, :campaign_description, :start_date, :end_date, :campaign_ranking, :spot_list, :channel_list
    #spot show page
    attr_reader :spot_name, :spot_text, :spot_ranking, :spot_redirect_url, :spot_redirect_type, :spot_image_url, :offer_resource
    #channel show page
    attr_reader :channel_name, :channel_type, :channel_identifier, :channel_description
    #shopping cart count
    attr_reader :total_cart_count
    #amt
    attr_reader :data
    #hotel 
    attr_reader :hotels, :aggregations

    def initialize(response)
      @response = response # Setting this temporarily so i can have a working member reg call, since it doesn't follow the resource [] best practices
      response.each { |key, value| instance_variable_set("@#{key}", value) if self.class.instance_methods.include? key.to_sym }
      @response_status = response.message
      @status ||= response.code
      check_success(response)
      if @success
        @info = Access::Info.new(@info) if @info
        (@links = @links.is_a?(Array) ? Access::Link.process_batch(@links) : Access::Link.new(@links)) if @links
        process_data
      end
    end

    def check_success(response)
      if response.success?
        @success = true
      else
        create_error
      end
    end

    def create_error
      @success = false
      @error = Access::Error.new(@response_status, @status, @message)
      remove_instance_variable(:@message) if @message
    end
  end

  class OfferResponse < Response
    def process_data
      # for when you search and it returns 0
      (@offers = []; create_error) if @message
      @offers = Access::Offer.process_batch(@offers) if @offers
      @offer_count_in_categories = Access::Aggregations.process_batch(@offer_count_in_categories) if @offer_count_in_categories
      @offer_count_by_redemption_method = Access::Aggregations.process_batch(@offer_count_by_redemption_method) if @offer_count_by_redemption_method
      @offer_count_by_facet = Access::Aggregations.process_batch(@offer_count_by_facet) if @offer_count_by_facet
      @custom_aggregation = Access::Aggregations.process_batch(@custom_aggregation) if @custom_aggregation
    end
  end

  class ProductGroupResponse < Response
    def process_data
      (@product_groups = []; create_error) if @message
      @product_groups = Access::ProductGroup.process_batch(@product_groups) if @product_groups
    end
  end

  class HotelResponse < Response
    def process_data
      (@hotels = []; create_error) if @message
      @hotels = Access::Hotel.process_batch(@hotels) if @hotels
      @aggregations = Access::Hotel.process_batch(@aggregations) if @aggregations
    end
  end

  class StoreResponse < Response
    def process_data
      (@stores = []; create_error) if @message
      @stores = Access::Store.process_batch(@stores) if @stores
      @offer_count_in_categories = Access::Aggregations.process_batch(@offer_count_in_categories) if @offer_count_in_categories
      @custom_aggregation = Access::Aggregations.process_batch(@custom_aggregation) if @custom_aggregation
    end
  end

  class ShoppingCartResponse < Response
    def process_data
    end
  end

  class LocationResponse < Response
    def process_data
      (@locations = []; create_error) if @message
      @locations = Access::Location.process_batch(@locations) if @locations
      @custom_aggregation = Access::Aggregations.process_batch(@custom_aggregation) if @custom_aggregation
    end
  end

  class CategoryResponse < Response
    def process_data
      (@categories = []; create_error) if @message
      @categories = Access::Category.process_batch(@categories) if @categories
    end
  end

  class AutocompleteResponse < Response
    def process_data
      # (@suggestions = []; create_error) if @message
      @suggestions = Access::Autocomplete.new(@suggestions)
    end
  end

  class OauthApplicationResponse < Response
    def process_data
      (@oauth_applications = []; create_error) if @message
      @oauth_applications = Access::OauthApplication.process_batch(@oauth_applications)
    end
  end

  class TokenResponse < Response
    def process_data
      (create_error) if @message
      @access_tokens = Access::Token.process_batch(@access_tokens) if @access_tokens
      @oauth_tokens = Access::Token.process_batch(@oauth_tokens) if @oauth_tokens
      @oauth_token = Access::Token.new(@oauth_token) if @oauth_token
    end
  end

  class VerifyResponse < Response
    def process_data
      @oauth_access_token = Access::Verify.new(@oauth_access_token) if @oauth_access_token
      @offers = Access::Verify.new(@offers) if @offers
      @categories = Access::Verify.new(@categories) if @categories
      @locations = Access::Verify.new(@locations) if @locations
      @stores = Access::Verify.new(@stores) if @stores
    end
  end

  class RedeemResponse < Response
    def process_data
      @details = Access::Redeem.new(@details) if @details
    end
  end

  class ReportResponse < Response
    def process_data
      @api_calls_over_time = Access::Report.process_batch(@api_calls_over_time) if @api_calls_over_time
      @member_query_terms = Access::Report.process_batch(@member_query_terms) if @member_query_terms
      @member_usage = Access::Report.process_batch(@member_usage) if @member_usage
      @member_postal_codes = Access::Report.process_batch(@member_postal_codes) if @member_postal_codes
    end
  end

  class ProgramResponse < Response
    def process_data
       @programs = Access::Program.process_batch([@response])
    end
  end

  class UserResponse < Response
    def process_data
      if @members && @members.any?
        @members = Access::Member.process_batch(@members)
        @users = @members.map {|x| x if x.try(:user) }.compact
      elsif @users && @users.any?
        @users = Access::User.process_batch(@users)
      end
    end
  end

  class MemberResponse < Response
    def process_data
      @members = Access::Member.process_batch(@members) if @members
    end
  end

  class DeviceResponse < Response
    def process_data
      @devices = Access::Device.process_batch(@devices) if @devices
    end
  end

  class FilterResponse < Response
    def process_data
      @filters = Access::Filter.process_batch(@filters)
    end
  end

  class CitySavingsResponse < Response
    def process_data

    end
  end

  class ChannelResponse < Response
    def process_data
      @channels = Access::Channel.process_batch(@channels) if @channels
    end
  end

  class CampaignResponse < Response
    def process_data
      @campaigns = Access::Campaign.process_batch(@campaigns) if @campaigns
      @spot_list = Access::Spot.process_batch(@spot_list) if @spot_list
      @channel_list = Access::Channel.process_batch(@channel_list) if @channel_list
    end
  end

  class SpotResponse < Response
    def process_data
      @spots = Access::Spot.process_batch(@spots) if @spots
      @offer_resource =  Access::Offer.new(@offer_resource) if @offer_resource
    end
  end

  class RedemptionResponse < Response
    def process_data
      (@offer_redemptions = []; create_error) if @message
      @offer_redemptions = Access::Redemption.process_batch(@offer_redemptions)
    end
  end

  class FavoriteResponse < Response
    def process_data
      (@favorites = []; create_error) if @message
      @favorites = Access::Favorite.process_batch(@favorites) if @favorites
    end
  end

  class GeolocationResponse < Response
    def process_data
      @locations = Access::Geolocation.process_batch(@locations) if @locations
    end
  end

  class AmtResponse < Response
    def process_data
      @data = Access::Amt.process_batch(@data) if @data
    end

    def all_valid?
      @data.all?{|import| import.invalid_members_count.zero? }
    end
  end

end
