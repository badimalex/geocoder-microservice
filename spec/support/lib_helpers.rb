module LibHelpers
  def fixture_path
    @fixture_path ||= File.expand_path('../fixtures', __dir__)
  end
end
