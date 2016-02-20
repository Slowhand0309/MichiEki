# encoding: utf-8
require "michieki"
require "spec_helper"

RSpec.describe MichiEki::Query do

  it 'empty hash' do
    query = MichiEki::Query.new
    ret = query.search_data(Hash.new, nil)
    expect(ret).to eq nil
  end

  it 'not match' do
    name = 'you'
    query_data = {'me' => {'name' => 'me', :value => 'value'}}

    query = MichiEki::Query.new
    ret = query.search_data(query_data, name)
    expect(ret).to eq nil
  end

  it 'match' do
    name = 'you'
    query_data = {'you+me' => {'name' => 'you+me', :value => 'value'}}

    query = MichiEki::Query.new
    ret = query.search_data(query_data, name)
    expect(ret['name']).to eq 'you+me'
  end
end
