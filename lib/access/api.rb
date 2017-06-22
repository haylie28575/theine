module Access
  class Api

    # Categories
    def search_categories(options = {})
      request.get("/categories", "offer", options) do |response|
        CategoryResponse.new(response)
      end
    end

    def find_category(category_key, options = {})
      request.get("/categories/#{category_key}", "offer", options) do |response|
        CategoryResponse.new(response)
      end
    end

    # Offers
    def search_offers(options = {})
      request.get("/offers", "offer", options) do |response|
        OfferResponse.new(response)
      end
    end

    def find_offer(offer_key, options = {})
      request.get("/offers/#{offer_key}", "offer", options) do |response|
        OfferResponse.new(response)
      end
    end

    def find_offer_uses_remaining(offer_key, options = {})
      request.get("/offers/#{offer_key}/uses_remaining", "offer", options) do |response|
        OfferResponse.new(response)
      end
    end

    #Product Groups
    def search_product_groups(options = {})
      request.get("/product_groups", "offer", options) do |response|
        ProductGroupResponse.new(response)
      end
    end

    #Hotels
    def search_hotels(options = {})
      request.get("/hotels", "hotel", options) do |response|
        HotelResponse.new(response)
      end
    end

    def find_hotel(hotel_key, options = {})
      request.get("/hotels/#{hotel_key}", "hotel", options) do |response|
        HotelResponse.new(response)
      end
    end

    # Locations
    def search_locations(options = {})
      request.get("/locations", "offer", options) do |response|
        LocationResponse.new(response)
      end
    end

    def find_location(location_key, options = {})
      request.get("/locations/#{location_key}", "offer", options) do |response|
        LocationResponse.new(response)
      end
    end

    # Stores
    def search_stores(options = {})
      request.get("/stores", "offer", options) do |response|
        StoreResponse.new(response)
      end
    end

    def find_store(store_key, options = {})
      request.get("/stores/#{store_key}", "offer", options) do |response|
        StoreResponse.new(response)
      end
    end

    def national_stores(options={})
      request.get("/stores/national", "offer", options) do |response|
        StoreResponse.new(response)
      end
    end

    # Autocomplete
    def autocomplete(options = {})
      request.get("/autocomplete", "offer", options) do |response|
        AutocompleteResponse.new(response)
      end
    end

    # Redeem
    def redeem_offer(offer_key, redeem_type = nil, options = {})
      request.get("/redeem/#{offer_key}/#{redeem_type}", "redeem", options) do |response|
        RedeemResponse.new(response)
      end
    end

    # CitySavings
    def search_city_savings(options = {})
      # this is broken
      request.get("/citysavings", "allcitysavings", options) do |response|
        CitySavingsResponse.new(response)
      end
    end

    # Channel
    def search_channels(options = {})
      request.get("/channels", "campaign", options) do |response|
        ChannelResponse.new(response)
      end
    end

    def find_channel(channel_key, options = {})
      request.get("/channels/#{channel_key}", "campaign", options) do |response|
        ChannelResponse.new(response)
      end
    end

    # Campaign
    def search_campaigns(options = {})
      request.get("/campaigns", "campaign", options) do |response|
        CampaignResponse.new(response)
      end
    end

    def find_campaign(campaign_key, options = {})
      request.get("/campaigns/#{campaign_key}", "campaign", options) do |response|
        CampaignResponse.new(response)
      end
    end

    # Spot
    def search_spots_by_channel(channel_key, options = {})
      request.get("/spots/channel/#{channel_key}", "campaign", options) do |response|
        SpotResponse.new(response)
      end
    end

    def search_spots_by_campaign(campaign_key, options = {})
      request.get("/spots/campaign/#{campaign_key}", "campaign", options) do |response|
        SpotResponse.new(response)
      end
    end

    def find_spot(spot_key, options = {})
      request.get("/spots/#{spot_key}", "campaign", options) do |response|
        SpotResponse.new(response)
      end
    end

    # User
    def user_registration(options = {})
      request.post("/register", "mms", options) do |response|
        UserResponse.new(response)
      end
    end

    def user_update(options = {})
      request.put("/users", "mms", options) do |response|
        UserResponse.new(response)
      end
    end

    def user_authentication(options = {})
      request.post("/auth", "mms", options) do |response|
        UserResponse.new(response)
      end
    end

    def user_authentication_by_cvt(options = {})
      request.get("/auth", "mms", options) do |response|
        UserResponse.new(response)
      end
    end

    def user_authentication_by_member_key(options = {})
      request.get("/auth", "mms", options) do |response|
        UserResponse.new(response)
      end
    end

    # Member
    def member_show(member_key, options = {})
      request.get("/members/#{member_key}", 'mms', options) do |response|
        MemberResponse.new(response)
      end
    end

    def member_update(member_key, options = {})
      request.put("/members/#{member_key}?program_id=#{options.delete(:program_id)}", 'mms', options) do |response|
        MemberResponse.new(response)
      end
    end

    # Device
    def search_devices(member_key, options = {})
      request.get("/members/#{member_key}/devices", 'mms', options) do |response|
        DeviceResponse.new(response)
      end
    end

    def find_device(member_key, options = {})
      request.get("/members/#{member_key}/devices/#{options.delete(:udid)}", 'mms', options) do |response|
        DeviceResponse.new(response)
      end
    end

    # Program
    def find_program_provisioning_method(pcid)
      request.get("/programs/#{pcid}", "mms") do |response|
        ProgramResponse.new(response)
      end
    end

    # Offer Redemptions
    def search_offer_redemptions_by_member(member_key, options = {})
      request.get("/members/#{member_key}/offer_redemptions", "report", options) do |response|
        RedemptionResponse.new(response)
      end
    end

    def find_offer_redemptions_by_member(member_key, usage_redeem_key, options = {})
      request.get("/members/#{member_key}/offer_redemptions/#{usage_redeem_key}", "report", options) do |response|
        RedemptionResponse.new(response)
      end
    end

    # Internal Admin only Call Below

    # Filters
    def search_filters(options = {})
      # Internal Admin only Call
      request.get("/filters", "token", options) do |response|
        FilterResponse.new(response)
      end
    end

    def find_filter(application_key, options = {})
      # Internal Admin only Call
      request.get("/filters/#{application_key}", "token", options) do |response|
        FilterResponse.new(response)
      end
    end

    # Oauth Applications
    def search_oauth_applications(options = {})
      # Internal Admin only Call
      request.get("/oauth_applications", 'token', options) do |response|
        OauthApplicationResponse.new(response)
      end
    end

    def find_oauth_application(application_key, options = {})
      # Internal Admin only Call
      request.get("/oauth_applications/#{application_key}", 'token', options) do |response|
        OauthApplicationResponse.new(response)
      end
    end

    def search_oauth_application_tokens(application_key, options = {})
      # Internal Admin only Call
      request.get("/oauth_applications/#{application_key}/access_tokens", 'token', options) do |response|
        TokenResponse.new(response)
      end
    end

    def find_oauth_application_token(application_key, token_key, options = {})
      # Internal Admin only Call
      request.get("/oauth_applications/#{application_key}/access_tokens/#{token_key}", 'token', options) do |response|
        TokenResponse.new(response)
      end
    end

    def create_oauth_application_token(application_key, options = {})
      # Internal Admin only Call
      request.create("/oauth_applications/#{application_key}/access_tokens", 'token', options) do |response|
        # TokenResponse.new(response)
        # OauthApplicationResponse.new(response)
      end
      # create("/oauth_applications/#{application_key}/access_tokens", 'token', options)
    end

    def create_oauth_application(options = {})
      # Internal Admin only Call
      request.create("/oauth_applications", 'token', options) do |response|
        OauthApplicationResponse.new(response)
      end
      # create("/oauth_applications", 'token', options)
    end

    def update_oauth_application(application_key, batch= {})
      # Internal Admin only Call
      request.put("/oauth_applications/#{application_key}", 'token', options) do |response|
        OauthApplicationResponse.new(response)
      end
      # put("/oauth_applications/#{application_key}", 'token', options)
    end

    def delete_oauth_application(application_key, options = {})
      # Internal Admin only Call
      request.delete("/oauth_applications/#{application_key}", 'token', options) do |response|
        OauthApplication.new(response)
      end
      # delete("/oauth_applications/#{application_key}", 'token', options)
    end

    # Access Tokens
    def search_tokens(options = {})
      # Internal Admin only Call
      request.get("/tokens", 'token', options) do |response|
        TokenResponse.new(response)
      end
    end

    def find_token(token, options = {})
      # Internal Admin only Call
      # new verify_other
      request.get("/tokens/#{token}", "token", options) do |response|
        TokenResponse.new(response)
      end
    end

    # Verify
    def verify_token(options = {})
      # Internal Admin only Call
      request.get("/verify", 'token', options) do |response|
        VerifyResponse.new(response)
      end
    end

    def verify_filter(filter, options = {})
      # Internal Admin only Call
      request.post_for_filter("/filter", 'token', filter, options) do |response|
        VerifyResponse.new(response)
      end
    end

    # Report
    def all_usage(options = {})
      # Internal Admin only Call
      request.get("/all_usage", "report", options) do |response|
        ReportResponse.new(response)
      end
    end

    def usage(options = {})
      # Internal Admin only Call
      request.get("/usage", "report", options) do |response|
        ReportResponse.new(response)
      end
    end

    def usage_other(token, options = {})
      # Internal Admin only Call
      request.get("/usage/#{token}", "report", options) do |response|
        ReportResponse.new(response)
      end
    end

    def member_query_frequent(member, options = {})
      request.get("/members/#{member}/queries/frequent", "report", options) do |response|
        ReportResponse.new(response)
      end
    end

    def member_query_recent(member, options = {})
      request.get("/members/#{member}/queries/recent", "report", options) do |response|
        ReportResponse.new(response)
      end
    end

    def member_location_frequent(member, options = {})
      request.get("/members/#{member}/locations/frequent", "report", options) do |response|
        ReportResponse.new(response)
      end
    end

    def member_location_recent(member, options = {})
      request.get("/members/#{member}/locations/recent", "report", options) do |response|
        ReportResponse.new(response)
      end
    end

    ## Favorites

    def favorites_search(options = {})
      request.get("/members/#{options.delete(:member_key)}/favorites/#{options.delete(:favorite_type)}", "report", options) do |response|
        FavoriteResponse.new(response)
      end
    end

    def favorites_find(resource_id, options = {})
      request.get("/members/#{options.delete(:member_key)}/favorites/#{options.delete(:favorite_type)}/#{resource_id}", "report", options) do |response|
        FavoriteResponse.new(response)
      end
    end

    def favorites_create(resource_id, options = {})
      request.post("/members/#{options.delete(:member_key)}/favorites/#{options.delete(:favorite_type)}/#{resource_id}", "mms", options) do |response|
        FavoriteResponse.new(response)
      end
    end

    def favorites_delete(resource_id, options = {})
      request.delete("/members/#{options.delete(:member_key)}/favorites/#{options.delete(:favorite_type)}/#{resource_id}", "mms", options) do |response|
        FavoriteResponse.new(response)
      end
    end

    ## Geolocation

    def geolocation_search(options = {})
      request.get('/geolocation', 'offer', options) do |response|
        GeolocationResponse.new(response)
      end
    end

    def geolocation_find(options = {})
      request.get('/geolocation/find_location', 'offer', options) do |response|
        GeolocationResponse.new(response)
      end
    end

    def get_shopping_cart_count(options= {})
      request.get('/cart/count', 'shoppingcart', options) do |response|
        ShoppingCartResponse.new(response)
      end
    end

    # AMT

    def import_members(members, options = {})
      request.post('/imports', 'amt', options.merge({import: {members: members}})) do |response|
        AmtResponse.new(response)
      end
    end

    def list_imports(options = {})
      request.get('/imports', 'amt', options) do |response|
        AmtResponse.new(response)
      end
    end

    def show_import(import_key, options = {})
      request.get("/imports/#{import_key}", 'amt', options) do |response|
        AmtResponse.new(response)
      end
    end

    private

    def request
      Access::Request.new
    end
  end
end
