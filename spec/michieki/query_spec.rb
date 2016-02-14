# encoding: utf-8
require "michieki"
require "spec_helper"

RSpec.describe MichiEki::Query do

  it 'empty hash' do
    query = MichiEki::Query.new
    ret = query.search_name(Hash.new, nil)
    expect(ret).to eq nil
  end

  it 'not match' do
    params = {:name => 'you'}
    query_data = {:key => {'name' => 'me', :value => 'you'}}

    query = MichiEki::Query.new
    ret = query.search_name(query_data, params)
    expect(ret).to eq nil
  end

  it 'match' do
    params = {:name => 'you'}
    query_data = {:key => {'name' => 'you', :value => 'me'}}

    query = MichiEki::Query.new
    ret = query.search_name(query_data, params)
    expect(ret['name']).to eq 'you'
  end
end
