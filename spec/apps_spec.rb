# frozen_string_literal: true

require 'vcr'
require 'simpleokta/apps'

RSpec.describe Simpleokta::Client::Apps do
  it 'returns a list of applications' do
    VCR.use_cassette('apps/all_apps') do
      response = client.apps
      expect(response).not_to be(nil)
    end
  end
  it 'returns a single application when passed an id' do
    VCR.use_cassette('apps/single_app') do
      response = client.app('0oaxf5krmAOlBwXdS5d6')
      expect(response['label']).to eq('Okta Admin Console')
      expect(response['name']).to eq('saasure')
      expect(response['created']).to eq('2021-06-10T15:04:42.000Z')
    end
  end
  it 'returns the users assigned to the app' do
    VCR.use_cassette('apps/app_users') do
      response = client.users_assigned_to_application('0oaxf5krmAOlBwXdS5d6')
      expect(response.first['id']).to eq('00uxf5kx9MpPC2jpb5d6')
    end
  end
  it 'creates an application when passed a valid request body' do
    VCR.use_cassette('apps/create_app') do
      app_data = {
        "name": "template_basic_auth",
        "label": "A New Application",
        "signOnMode": "BASIC_AUTH",
        "settings": {
          "app": {
            "url": "https://example.com/login.html",
            "authURL": "https://example.com/auth.html"
          }
        }
      }
      response = client.create_app(app_data)
      expect(response['id']).to eq('0oa10ggguzH2JBB0I5d7')
      expect(response['label']).to eq('A New Application')
    end
  end
  it 'updates an app when passed a valid app_data object' do
    VCR.use_cassette('apps/update_app') do
      app_data = {
        "name": "template_basic_auth",
        "label": "A New Application: Electric Boogaloo",
        "signOnMode": "BASIC_AUTH",
        "settings": {
          "app": {
            "url": "https://example.com/login.html",
            "authURL": "https://example.com/auth.html"
          }
        }
      }
      response = client.update_app('0oa10ggguzH2JBB0I5d7', app_data)
      expect(response['id']).to eq('0oa10ggguzH2JBB0I5d7')
      expect(response['label']).to eq('A New Application: Electric Boogaloo')
    end
  end
end
