# encoding: utf-8
require "michieki"
require "spec_helper"

RSpec.describe MichiEki::Finder do

  it 'hit' do
    params = {:lat => 35.68, :lng => 139.69} # => 東京都周辺
    finder = MichiEki::Finder.new
    ret = finder.find(params)

    expect(ret.size).to eq 2
    expect(ret[0]['name']).to eq '川口・あんぎょう'
    expect(ret[1]['name']).to eq '庄和'
  end

end
