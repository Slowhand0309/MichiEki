require "michieki"
require "spec_helper"

RSpec.describe MichiEki::Finder do

  it 'hit' do
    params = {:lat => 35.68, :lng => 139.69} # => 東京都
    finder = MichiEki::Finder.new
    ret = finder.find(params)

    puts ret # TODO for debug
  end

end
