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

    end
    it 'returns an error hash when passed invalid parameters' do

    end
    it 'returns an error when passed an invalid group_id' do

    end
  end
  describe '#delete_user' do
    it 'returns an error when the user is not deactivated' do

    end
    it 'deletes a user when the user has a status of DEPROVISIONED' do

    end
    it 'sets a user status to DEACTIVATED when called on a user whose status != DEACTIVATED' do

    end
    it 'returns an error when passed an invalid user_id' do

    end
  end
  describe '#update_user' do
    it 'updates a user when passed valid parameters' do

    end
    it 'returns an error hash when passed invalid parameters' do

    end
    it 'returns an error when passed an invalid user_id' do

    end
  end
  describe '#activate_user' do
    it 'activates a user when the given user is deactivated' do

    end
    it 'returns a 403 error code when the given user is already active' do

    end
    it 'returns an error when passed an invalid user_id' do

    end
    it 'returns the expected body' do

    end
  end
  describe '#reactivate_user' do
    it 'reactivates a user when the given user is deactivated' do

    end
    it 'returns a 403 error code when the given user is already active' do

    end
    it 'returns an error when passed an invalid user_id' do

    end
    it 'returns the expected body' do

    end
  end
  describe '#deactivate_user' do
    it 'deactivates a user when the given user is active' do

    end
    it 'returns a 403 error code when the given user is already deactivated' do

    end
    it 'returns an error when passed an invalid user_id' do

    end
    it 'returns a status code of 200' do

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
