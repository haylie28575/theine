module Access
  class Info
    include Access::MuchMeta

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @geolocation = Access::Geolocation.new(@geolocation) if @geolocation
    end

  end
end

