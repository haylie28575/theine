module Access
  class Organization
    include Access::MuchMeta

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

  end
end
