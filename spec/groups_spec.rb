# frozen_string_literal: true

require 'vcr'
require 'simpleokta/groups'

RSpec.describe Simpleokta::Client::Groups do
  let(:working_group_id) {
    '00g10pnp6v3Brgwlx5d7'
  }
  describe 'GROUP METHODS' do
    describe '#groups' do
      it 'returns an array' do
        VCR.use_cassette('groups/groups') do
          response = client.groups
          expect(response.class).to eq(Array)
        end
      end
    end
    describe '#group' do
      it 'returns a hash when passed a valid id' do
        VCR.use_cassette('groups/group') do
          response = client.group('00gxf5kry6skrJf095d6')
          expect(response['profile'].class).to eq(Hash)
          expect(response['profile']['name']).to eq('Everyone')
          expect(response['profile']['description']).to eq('All users in your organization')
        end
      end
      it 'returns an error when passed a valid id' do
        VCR.use_cassette('groups/invalid_group') do
          response = client.group('invalidid')
          expect(response['errorCode']).to eq('E0000007')
          expect(response['errorSummary']).to eq('Not found: Resource not found: invalidid (UserGroup)')
        end
      end
    end
    describe '#apps_assigned_to_group' do
      it 'returns an array when passed a valid id' do
        VCR.use_cassette('groups/group_apps') do
          response = client.apps_assigned_to_group('00gxf5kry6skrJf095d6')
          expect(response.class).to eq(Array)
        end
      end
      it 'returns an error when passed an invalid id' do
        VCR.use_cassette('groups/invalid_group_apps') do
          response = client.group('invalidid')
          expect(response['errorCode']).to eq('E0000007')
          expect(response['errorSummary']).to eq('Not found: Resource not found: invalidid (UserGroup)')
        end
      end
    end
    describe '#assign_group_to_application' do
      it 'returns an application group when passed valid ids' do
        VCR.use_cassette('groups/assign_group') do
          response = client.assign_group_to_application('0oayt04y5o7ecjjU05d6', working_group_id)
          expect(response['id']).to eq(working_group_id)
          expect(response['_links'].keys).to eq(['app','self','group'])
        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_assign_group_group') do
          response = client.assign_group_to_application('0oayt04y5o7ecjjU05d6', 'invalidid')
          expect(response['errorCode']).to eq('E0000007')
          expect(response['errorSummary']).to eq('Not found: Resource not found: invalidid (UserGroup)')
        end
      end
      it 'returns an error when passed an invalid app id' do
        VCR.use_cassette('groups/invalid_assign_group_app') do
          response = client.assign_group_to_application('invalidid', working_group_id)
          expect(response['errorCode']).to eq('E0000007')
          expect(response['errorSummary']).to eq('Not found: Resource not found: invalidid (AppInstance)')
        end
      end
    end
    describe '#remove_group_from_application' do
      it 'returns a 204 status code when passed valid ids' do
        VCR.use_cassette('groups/remove_group_from_app') do
          response = client.remove_group_from_application('0oayt04y5o7ecjjU05d6', working_group_id)
          expect(response.code).to eq(204)
        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_remove_group_from_app') do
          response = client.remove_group_from_application('0oayt04y5o7ecjjU05d6', 'invalidid')
          expect(JSON.parse(response)['errorCode']).to eq('E0000007')
          expect(JSON.parse(response)['errorSummary']).to eq('Not found: Resource not found: invalidid (UserGroup)')
        end
      end
      it 'returns an error when passed an invalid app id' do
        VCR.use_cassette('groups/invalid_remove_group_from_app_app') do
          response = client.remove_group_from_application('invalidid', working_group_id)
          expect(JSON.parse(response)['errorCode']).to eq('E0000007')
          expect(JSON.parse(response)['errorSummary']).to eq('Not found: Resource not found: invalidid (AppInstance)')
        end
      end
    end
    describe '#get_assigned_group_for_application' do
      it 'returns a group assignment object when passed a valid app id' do
        VCR.use_cassette('groups/get_group_for_app') do
          response = client.get_assigned_group_for_application('0oayt04y5o7ecjjU05d6', working_group_id)
          expect(response['id']).to eq(working_group_id)
          expect(response['_links'].keys).to eq(['app','self','group'])
        end
      end
      it 'returns an error when passed an invalid app id' do
        VCR.use_cassette('groups/invalid_get_group_for_app') do
          response = client.get_assigned_group_for_application('invalidid', working_group_id)
          expect(response['errorCode']).to eq('E0000007')
          expect(response['errorSummary']).to eq('Not found: Resource not found: invalidid (AppInstance)')
        end
      end
    end
    describe '#update_group' do
      it 'returns the new group data when passed valid data' do
        VCR.use_cassette('groups/update_group') do
          group_data = {
            profile: {
              name: 'New Working Group',
              description: 'Keep Calm and Single Sign On'
            }
          }
          response = client.update_group(working_group_id, group_data)
          expect(response['id']).to eq(working_group_id)
          expect(response['profile']['name']).to eq('New Working Group')
          expect(response['profile']['description']).to eq('Keep Calm and Single Sign On')
        end
      end
      it 'returns an error when passed invalid data' do
        VCR.use_cassette('groups/invalid_update_group') do
          group_data = {
            boop: 'bap'
          }
          response = client.update_group(working_group_id, group_data)
          expect(response['errorCode']).to eq('E0000003')
          expect(response['errorSummary']).to eq('The request body was not well-formed.')
        end
      end
    end
    describe '#remove_group' do
      it 'returns a 204 when pased a valid group id' do
        VCR.use_cassette('groups/remove_group') do
          response = client.remove_group('00g11z4uzrfUJaw3d5d7')
          expect(response.code).to eq(204)
        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_remove_group') do
          response = client.remove_group('invalidid')
          expect(JSON.parse(response)['errorCode']).to eq('E0000007')
          expect(JSON.parse(response)['errorSummary']).to eq('Not found: Resource not found: invalidid (UserGroup)')
        end
      end
    end
    describe '#group_members' do
      it 'returns an array of User objects when passed a valid group id' do
        VCR.use_cassette('groups/group_members') do
          response = client.group_members(working_group_id)
          expect(response.class).to eq(Array)
        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_group_members') do
          response = client.group_members('invalidid')
          expect(response['errorCode']).to eq('E0000007')
          expect(response['errorSummary']).to eq('Not found: Resource not found: invalidid (UserGroup)')
        end
      end
    end
    describe '#add_user_to_group' do
      it 'returns a 204 status code when pased a valid group id' do
        VCR.use_cassette('groups/add_user_to_group') do
          response = client.add_user_to_group(working_group_id, '00u10ribsoVWUttmX5d7')
          expect(response.code).to eq(204)
        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_add_user_to_group') do
          response = client.add_user_to_group('invalidid', '00u10ribsoVWUttmX5d7')
          expect(JSON.parse(response)['errorCode']).to eq('E0000007')
          expect(JSON.parse(response)['errorSummary']).to eq('Not found: Resource not found: invalidid (UserGroup)')
        end
      end
      it 'returns an error when passed an invalid user id' do
        VCR.use_cassette('groups/invalid_user_app_user_to_group') do
          response = client.add_user_to_group(working_group_id, 'invalidid')
          expect(JSON.parse(response)['errorCode']).to eq('E0000007')
          expect(JSON.parse(response)['errorSummary']).to eq('Not found: Resource not found: invalidid (User)')
        end
      end
    end
    describe '#remove_user_from_group' do
      it 'returns a 204 when pased a valid group id' do
        VCR.use_cassette('groups/remove_user_from_group') do
          response = client.remove_user_from_group(working_group_id, '00u10ribsoVWUttmX5d7')
          expect(response.code).to eq(204)
        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_remove_user_from_group') do
          response = client.remove_user_from_group(working_group_id, 'invalidid')
          expect(JSON.parse(response)['errorCode']).to eq('E0000007')
          expect(JSON.parse(response)['errorSummary']).to eq('Not found: Resource not found: invalidid (User)')
        end
      end
      it 'returns an error when passed an invalid user id' do
        VCR.use_cassette('groups/invalid_user_remove_user_from_group') do
          response = client.remove_user_from_group('invalidid', '00u10ribsoVWUttmX5d7')
          expect(JSON.parse(response)['errorCode']).to eq('E0000007')
          expect(JSON.parse(response)['errorSummary']).to eq('Not found: Resource not found: invalidid (UserGroup)')
        end
      end
    end
  end
end
