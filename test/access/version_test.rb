require './test/test_helper'

class VersionTest < Minitest::Test

  def test_must_be_defined
    assert Access::VERSION
  end

end
