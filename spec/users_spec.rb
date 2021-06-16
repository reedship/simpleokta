# frozen_string_literal: true

require 'vcr'
require 'simpleokta/users'

RSpec.describe Simpleokta::Client::Users do
  let(:bradens_id) {'00uxf5kx9MpPC2jpb5d6'}
  let(:profile_object) do
    profile_object = {
      profile: {
        firstName: 'Isaac',
        lastName: 'Brock',
        email: 'isaac.brock@example.com',
        login: 'isaac.brock@example.com',
        mobilePhone: '555-415-1337'
      }
    }
  end
  describe '#users' do
    it 'returns a list of users' do
      VCR.use_cassette('users/all_users') do
        response = client.users
        expect(response.class).to be(Array)
        expect(response).not_to be(nil)
      end
    end
  end
  describe '#user' do
    it 'returns a single user when passed a valid id' do
      VCR.use_cassette('users/single_user') do
        response = client.user(bradens_id)
        expect(response['id']).to eq(bradens_id)
        expect(response['created']).to eq('2021-06-10T15:04:48.000Z')
      end
    end
    it 'returns an error hash when passed an invalid id' do
      VCR.use_cassette('users/invalid_user') do
        response = client.user('asdfasdfsadfsadf')
        expect(response['errorCode']).to eq('E0000007')
        expect(response['errorSummary']).to eq('Not found: Resource not found: asdfasdfsadfsadf (User)')
      end
    end
  end
  describe '#user_from_login' do
    it 'returns a single user when passed a valid login email' do
      VCR.use_cassette('users/user_from_login') do
        response = client.user('bradenrshipley@gmail.com')
        expect(response['id']).to eq(bradens_id)
        expect(response['created']).to eq('2021-06-10T15:04:48.000Z')
      end
    end
    it 'returns an error hash when passed an invalid login email' do
      VCR.use_cassette('users/invalid_user_from_login') do
        response = client.user('auserthatdoesnotexist@domain.com')
        expect(response['errorCode']).to eq('E0000007')
        expect(response['errorSummary']).to eq('Not found: Resource not found: auserthatdoesnotexist@domain.com (User)')
      end
    end
  end
  describe '#create_user' do
    it 'creates a user when passed valid profile object' do
      VCR.use_cassette('users/create_user') do
        response = client.create_user(profile_object)
        expect(response['id']).to eq('00u10onqttoutdqBf5d7')
        expect(response['profile']['firstName']).to eq('Isaac')
        expect(response['profile']['lastName']).to eq('Brock')
      end
    end
    it 'returns an error hash when passing invalid parameters' do
      VCR.use_cassette('users/invalid_create_user') do
        response = client.create_user({boop: 'bap'})
        expect(response['errorCode']).to eq('E0000003')
        expect(response['errorSummary']).to eq('The request body was not well-formed.')
      end
    end
  end
  describe '#create_and_activate_user' do
    it 'creates an active user when passed a valid profile object' do
      VCR.use_cassette('users/create_and_activate_user') do
        response = client.create_and_activate_user(profile_object)
        expect(response['status']).to eq('PROVISIONED')
        expect(response['activated']).not_to eq(nil)
        expect(response['profile']['firstName']).to eq('Isaac')
        expect(response['profile']['lastName']).to eq('Brock')
      end
    end
    it 'returns an error hash when passing invalid parameters' do
      VCR.use_cassette('users/invalid_create_and_activate') do
        response = client.create_and_activate_user({boop: 'bap'})
        expect(response['errorCode']).to eq('E0000003')
        expect(response['errorSummary']).to eq('The request body was not well-formed.')
      end
    end
  end
  describe '#create_user_in_group' do
    it 'creates a user in a given group when passed valid parameters' do
      VCR.use_cassette('users/create_user_in_group') do
        response = client.create_user_in_group(profile_object, ['00g10pnp6v3Brgwlx5d7'])
        expect(response['id']).to eq('00u10pwwcjHUTNRmU5d7')
        expect(response['profile']['firstName']).to eq('Isaac')
        expect(response['profile']['lastName']).to eq('Brock')
      end
    end
    it 'returns an error hash when passed invalid parameters' do
      VCR.use_cassette('users/invalid_create_user_in_group') do
        response = client.create_user_in_group({boop: 'bap'}, ['00g10pnp6v3Brgwlx5d7'])
        expect(response['errorCode']).to eq('E0000003')
        expect(response['errorSummary']).to eq('The request body was not well-formed.')
      end
    end
    it 'returns an error when passed an invalid group_id' do
      VCR.use_cassette('users/invalid_group_create_user_in_group') do
        response = client.create_user_in_group(profile_object, ['12345678901011'])
        expect(response['errorCode']).to eq('E0000007')
        expect(response['errorSummary']).to eq('Not found: Resource not found: 12345678901011 (UserGroup)')
      end
    end
  end
  describe '#delete_user' do
    it 'deletes a user when the user has a status of DEPROVISIONED' do
      VCR.use_cassette('users/delete_user') do
        response = client.delete_user('00u10q3ie478QZVxc5d7')
        expect(response.code).to eq(204)
      end
    end
    it 'sets a user status to DEACTIVATED when called on a user whose status != DEACTIVATED' do
      VCR.use_cassette('users/delete_user_active') do
        client.delete_user('00u10ribsoVWUttmX5d7')
        response = client.user('00u10ribsoVWUttmX5d7')
        expect(response['status']).to eq('DEPROVISIONED')
      end
    end
    it 'returns a 404 when passed an invalid user_id' do
      VCR.use_cassette('users/invalid_delete_user') do
        response = client.delete_user('somethingfake')
        expect(response.code).to eq(404)
      end
    end
  end
  describe '#update_user' do
    it 'returns an error hash when passed invalid parameters' do
      VCR.use_cassette('users/invalid_update_user') do
        new_profile_data = {
          profile: {
            mobilePhone: '555-415-1337'
          }
        }
        response = client.update_user('00u10ribsoVWUttmX5d7', new_profile_data)
        expect(response['errorCode']).to eq('E0000001')
        expect(response['errorCauses'].count).to eq(5)
      end
    end
    it 'updates a user when passed valid parameters' do
      VCR.use_cassette('users/update_user') do
        new_profile_data = {
          profile: {
            firstName: 'Isaac2',
            lastName: 'Brock2',
            email: 'isaac.brock2@example.com',
            login: 'isaac.brock@example.com',
            mobilePhone: '555-415-1337'
          }
        }
        response = client.update_user('00u10ribsoVWUttmX5d7', new_profile_data)
        expect(response['profile']['firstName']).to eq('Isaac2')
        expect(response['profile']['lastName']).to eq('Brock2')
        expect(response['profile']['mobilePhone']).to eq('555-415-1337')
      end
    end
    it 'returns an error when passed an invalid user_id' do
      VCR.use_cassette('users/invalid_id_update_user') do
        profile_data = {
          profile: {
            firstName: 'David',
            lastName: 'David',
            email: 'david.david@example.com',
            login: 'david.david@example.com',
            mobilePhone: '555-415-1337'
          }
        }
        response = client.update_user('fakeuserid', profile_data)
        expect(response['errorCode']).to eq('E0000007')
        expect(response['errorSummary']).to eq('Not found: Resource not found: fakeuserid (User)')
      end
    end
  end
  describe '#activate_user' do
    it 'activates a user when the given user is deactivated' do
      VCR.use_cassette('users/activate_user') do
        response = client.activate_user('00u10q2zmvugkWr7d5d7', false)
        expect(response).not_to be(nil)
      end
    end
    it 'returns a 403 error code when the given user is already active' do
      VCR.use_cassette('users/invalid_activate_user') do
        response = client.activate_user('00u10q2zmvugkWr7d5d7', false)
        expect(response['errorCode']).to eq('E0000016')
        expect(response['errorSummary']).to eq('Activation failed because the user is already active')
      end
    end
    it 'returns an error when passed an invalid user_id' do
      VCR.use_cassette('users/invalid_id_activate_user') do
        response = client.activate_user('fakeuserid', false)
        expect(response['errorCode']).to eq('E0000007')
        expect(response['errorSummary']).to eq('Not found: Resource not found: fakeuserid (User)')
      end
    end
    it 'returns the expected body' do
      VCR.use_cassette('users/activate_user') do
        response = client.activate_user('00u10q2zmvugkWr7d5d7', false)
        expect(response.keys).to eq(['activationUrl','activationToken'])
      end
    end
  end
  describe '#reactivate_user' do
    it 'reactivates a user when their status is PROVISIONED' do
        VCR.use_cassette('users/reactivate_user') do
          response = client.reactivate_user('00u10ribsoVWUttmX5d7', false)
          expect(response['activationToken']).not_to be(nil)
        end
    end
    it 'returns an error hash when the given user is already active' do
        VCR.use_cassette('users/reactivate_user_already_active') do
          response = client.reactivate_user(bradens_id, false)
          p response
        expect(response['errorCode']).to eq('E0000038')
        expect(response['errorSummary']).to eq('This operation is not allowed in the user\'s current status.')
        end
    end
    it 'returns an error when passed an invalid user_id' do
      VCR.use_cassette('users/invalid_reactivate_user') do
        response = client.reactivate_user('fakeuserid', false)
        expect(response['errorCode']).to eq('E0000007')
        expect(response['errorSummary']).to eq('Not found: Resource not found: fakeuserid (User)')
      end
    end
    it 'returns the expected body' do
      VCR.use_cassette('users/reactivate_user') do
        response = client.reactivate_user('00u10ribsoVWUttmX5d7', false)
        expect(response.keys).to eq(['activationUrl','activationToken'])
      end
    end
  end
  describe '#deactivate_user' do
    it 'deactivates a user when the given user is active' do
      VCR.use_cassette('users/deactivate_user') do
        response = client.deactivate_user('00u10ribsoVWUttmX5d7', false)
        expect(response.code).to eq(200)
      end
    end
    it 'returns an error when passed an invalid user_id' do
      VCR.use_cassette('users/invalid_deactivate_user') do
        response = client.deactivate_user('fakeuserid', false)
        expect(response['errorCode']).to eq('E0000007')
        expect(response['errorSummary']).to eq('Not found: Resource not found: fakeuserid (User)')
      end

    end
  end
  describe '#suspend_user' do
    it 'suspends a user when passed a valid user_id' do

    end
    it 'returns an error when passed an invalid user_id' do

    end
    it 'returns an error when user does not have a status of ACTIVE' do

    end
    it 'returns a status code of 200' do

    end
  end
  describe '#unsuspend_user' do
    it 'suspends a user when passed a valid user_id' do

    end
    it 'returns an error when passed an invalid user_id' do

    end
    it 'returns an error when user does not have a status of SUSPENDED' do

    end
    it 'returns a status code of 200' do

    end
  end
  describe '#unlock_user' do
    it 'unlocks a user whose status == LOCKED_OUT' do

    end
    it 'returns a status code of 200' do

    end
    it 'sets the user status to ACTIVE' do

    end

  end
end
