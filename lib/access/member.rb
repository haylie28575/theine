module Access
  class Member
    include Access::MuchMeta

    def self.process_batch(chunk)
      chunk.map { |member| new(member) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @user  =  Access::User.new(@user) if @user
      @member  = Access::Member.new(@member.tap {|m| m.delete(:user) }) if @member
      @program = Access::Program.new(@program) if @program
      @organization = Access::Organization.new(@organization) if @organization
    end

    def self.show(member_key, options = {})
      Access::Api.new.member_show member_key, options
    end

    def self.update(member_key, options = {})
      Access::Api.new.member_update member_key, options
    end

  end
end
