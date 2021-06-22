# frozen_string_literal: true

require 'vcr'
require 'simpleokta/auth_servers'

RSpec.describe Simpleokta::Client::AuthServers do
  let(:auth_server_object) do
    {
      name: "New Authorization Server",
      description: "Authorization Server New Description",
      audiences: [
        "api://default"
      ]
    }
  end
  let(:invalid_auth_server_object) do
    {
      boop: 'bap'
    }
  end
  describe 'AUTH SERVER METHODS' do
    describe '#auth_servers' do
      it 'returns a list of auth servers' do
        VCR.use_cassette('auth_servers/auth_servers', match_requests_on: [:path]) do
          response = client.auth_servers
          expect(response.class).to be(Array)
          expect(response).not_to be_nil
        end
      end
    end
    describe '#auth_server' do
      it 'returns an auth server when passed a valid id' do
        VCR.use_cassette('auth_servers/auth_server', match_requests_on: [:path]) do
          response = client.auth_server('ausxf5ktkSSCqMgqt5d6')
          expect(response['id']).to eq('ausxf5ktkSSCqMgqt5d6')
          expect(response['name']).to eq('default')
          expect(response['id']).to eq('ausxf5ktkSSCqMgqt5d6')
        end
      end
      it 'returns an error when passed an invalid id' do
        VCR.use_cassette('auth_servers/invalid_auth_server', match_requests_on: [:path]) do
          response = client.auth_server('fakeuserid')
          expect(response['errorCode']).to eq('E0000007')
          expect(response['errorSummary']).to eq('Not found: Resource not found: fakeuserid (AuthorizationServer)')
        end
      end
    end
    describe '#create_auth_server' do
      it 'creates an auth server when passed a valid authorization server object' do
        VCR.use_cassette('auth_servers/create_auth_server', match_requests_on: [:path]) do
          response = client.create_auth_server(auth_server_object)
          expect(response['id']).to eq('aus110xphkcEtyhLv5d7')
          expect(response['name']).to eq('New Authorization Server')
        end
      end
      it 'returns an error when passed an invalid authorization server object' do
        VCR.use_cassette('auth_servers/invalid_create_auth_server', match_requests_on: [:path]) do
          response = client.create_auth_server(invalid_auth_server_object)
          expect(response['errorCode']).to eq('E0000001')
          expect(response['errorSummary']).to eq('Api validation failed: audiences')
        end
      end
    end
    describe '#update_auth_server' do
      it 'updates an auth server when passed a valid authorization server object' do
        VCR.use_cassette('auth_servers/update_auth_server', match_requests_on: [:path]) do
          new_data = {
            name: "New Updated Authorization Server Part Dos",
            description: "Authorization Server New Description: Fancy!",
            audiences: [
              "https://api.resource.com"
            ],
            issuerMode: "ORG_URL"
          }
          response = client.update_auth_server('aus110xphkcEtyhLv5d7', new_data)
          expect(response['id']).to eq('aus110xphkcEtyhLv5d7')
          expect(response['name']).to eq('New Updated Authorization Server Part Dos')
          expect(response['description']).to eq('Authorization Server New Description: Fancy!')
        end
      end
      it 'returns an error when passed an invalid authorization server object' do
        VCR.use_cassette('auth_servers/invalid_update_auth_server') do
          response = client.update_auth_server('aus110xphkcEtyhLv5d7', invalid_auth_server_object)
          expect(response['errorCode']).to eq('E0000001')
          expect(response['errorSummary']).to eq('Api validation failed: audiences')
        end
      end
    end
    describe '#delete_auth_server' do
      it 'returns a 204 status code' do
        VCR.use_cassette('auth_servers/delete_auth_server', match_requests_on: [:path]) do
          response = client.delete_auth_server('aus110xphkcEtyhLv5d7')
          expect(response.code).to eq(204)
        end
      end
      it 'returns an error when passed an invalid id' do
        VCR.use_cassette('auth_servers/invalid_delete_auth_server', match_requests_on: [:path]) do
          response = client.delete_auth_server('fakeuserid')
          expect(response.code).to eq(404)
          expect(JSON.parse(response)['errorCode']).to eq('E0000007')
          expect(JSON.parse(response)['errorSummary']).to eq('Not found: Resource not found: fakeuserid (AuthorizationServer)')
        end
      end
    end
    describe '#activate_auth_server' do
      it 'returns a 204 status code' do
        VCR.use_cassette('auth_servers/activate_auth_server', match_requests_on: [:path]) do
          response = client.activate_auth_server('aus1126khtc7OkUSC5d7')
          expect(response.code).to eq(204)
        end
      end
      it 'activates an authorization server' do
        VCR.use_cassette('auth_servers/active_after_activate_auth_server', match_requests_on: [:path]) do
          response = client.activate_auth_server('aus1126khtc7OkUSC5d7')
          auth_server = client.auth_server('aus1126khtc7OkUSC5d7')
          expect(response.code).to eq(204)
          expect(auth_server['status']).to eq('ACTIVE')
        end
      end
    end
    describe '#deactivate_auth_server' do
      it 'returns a 204 status code' do
        VCR.use_cassette('auth_servers/deactivate_auth_server', match_requests_on: [:path]) do
          response = client.activate_auth_server('aus1126khtc7OkUSC5d7')
          expect(response.code).to eq(204)
        end
      end
      it 'deactivates an authorization server' do
        VCR.use_cassette('auth_servers/inactive_after_deactivate_auth_server', match_requests_on: [:path]) do
          response = client.deactivate_auth_server('aus1126khtc7OkUSC5d7')
          auth_server = client.auth_server('aus1126khtc7OkUSC5d7')
          expect(response.code).to eq(204)
          expect(auth_server['status']).to eq('INACTIVE')
        end
      end
    end
  end

  describe 'POLICY METHODS' do
    describe '#policies' do
      it 'returns an array' do
        VCR.use_cassette('auth_servers/policies', match_requests_on: [:path]) do
          response = client.policies('aus1126khtc7OkUSC5d7')
          expect(response.class).to be(Array)
        end
      end
    end
    describe '#policy' do
      it 'returns a hash' do

      end
      it 'returns an error when passed an invalid policy_id' do

      end
      it 'returns an error when passed an invalid auth_server_id' do

      end

    end
    describe '#create_policy' do

    end
    describe '#update_policy' do

    end
    describe '#delete_policy' do

    end
  end

  describe 'POLICY RULE METHODS' do
    describe '#rules' do

    end
    describe '#rule' do

    end
    describe '#create_rule' do

    end
    describe '#update_rule' do

    end
    describe '#delete_rule' do

    end
  end

  describe 'SCOPES METHODS' do
    describe '#scopes' do

    end
    describe '#scope' do

    end
    describe '#create_scope' do

    end
    describe '#update_scope' do

    end
    describe '#delete_scope' do

    end
  end

   describe 'CLAIMS METHODS' do
     describe '#claims' do

     end
     describe '#claim' do

     end
     describe '#create_claim' do

     end
     describe '#update_claim' do

     end
     describe '#delete_claim' do

     end
   end

   describe 'KEY STORE OPERATIONS' do
     describe '#keys' do

     end
     describe '#key' do

     end
     describe '#rotate_keys' do

     end
   end

   describe 'CLIENT RESOURCE OPERATIONS' do
     describe '#client_resources' do

     end
   end
   describe 'OAUTH 2.0 TOKEN MGMT OPERATIONS' do
     describe '#refresh_tokens' do

     end
     describe '#refresh_token' do

     end
     describe '#revoke_refresh_tokens' do

     end
     describe '#revoke_refresh_token' do

     end
   end
end

