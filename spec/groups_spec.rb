# frozen_string_literal: true

require 'vcr'
require 'simpleokta/groups'

RSpec.describe Simpleokta::Client::Groups do
  describe 'GROUP METHODS' do
    describe '#groups' do
      it 'returns an array' do
        VCR.use_cassette('groups/groups') do

        end
      end
    end
    describe '#group' do
      it 'returns a hash when passed a valid id' do
        VCR.use_cassette('groups/group') do

        end
      end
      it 'returns an error when passed a valid id' do
        VCR.use_cassette('groups/invalid_group') do

        end
      end
    end
    describe '#apps_assigned_to_group' do
      it 'returns an array when passed a valid id' do
        VCR.use_cassette('groups/group_apps') do

        end
      end
      it 'returns an error when passed an invalid id' do
        VCR.use_cassette('groups/invalid_group_apps') do

        end
      end
    end
    describe '#assign_group_to_application' do
      it 'returns a 204 status code when passed valid ids' do
        VCR.use_cassette('groups/assign_group') do

        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_assign_group') do

        end
      end
      it 'returns an error when passed an invalid app id' do
        VCR.use_cassette('groups/invalid_assign_group') do

        end
      end
    end
    describe '#remove_group_from_application' do
      it 'returns a 204 status code when passed valid ids' do
        VCR.use_cassette('groups/remove_group_from_app') do

        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_remove_group_from_app') do

        end
      end
      it 'returns an error when passed an invalid app id' do
        VCR.use_cassette('groups/invalid_remove_group_from_app') do

        end
      end
    end
    describe '#get_assigned_group_for_application' do
      it 'returns a group when passed a valid app id' do
        VCR.use_cassette('groups/get_group_for_app') do

        end
      end
      it 'returns an error when passed an invalid app id' do
        VCR.use_cassette('groups/get_group_for_app') do

        end
      end
    end
    describe '#update_group' do
      it 'returns the new group data when passed valid data' do
        VCR.use_cassette('groups/update_group') do

        end
      end
      it 'returns an error when passed invalid data' do
        VCR.use_cassette('groups/invalid_update_group') do

        end
      end
    end
    describe '#remove_group' do
      it 'returns a 204 when pased a valid group id' do
        VCR.use_cassette('groups/remove_group') do

        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_remove_group') do

        end
      end
    end
    describe '#group_members' do
      it 'returns an array of User objects when passed a valid group id' do
        VCR.use_cassette('groups/group_members') do

        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_group_members') do

        end
      end
    end
    describe '#add_user_to_group' do
      it 'returns a 204 when pased a valid group id' do
        VCR.use_cassette('groups/add_user_togroup') do

        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_add_user_to_group') do

        end
      end
      it 'returns an error when passed an invalid user id' do
        VCR.use_cassette('groups/invalid_app_user_to_group') do

        end
      end
    end
    describe '#remove_user_from_group' do
      it 'returns a 204 when pased a valid group id' do
        VCR.use_cassette('groups/remove_user_from_group') do

        end
      end
      it 'returns an error when passed an invalid group id' do
        VCR.use_cassette('groups/invalid_remove_user_from_group') do

        end
      end
      it 'returns an error when passed an invalid user id' do
        VCR.use_cassette('groups/invalid_remove_user_from_group') do

        end
      end
    end
  end
  describe 'GROUP RULE METHODS' do
    describe '#group_rules' do
      it 'returns an array of rule objects' do
        VCR.use_cassette('groups/group_rules') do

        end
      end
    end
    describe '#group_rule' do
      it 'returns a hash when passed a valid group rule id' do
        VCR.use_cassette('groups/group_rule') do

        end
      end
      it 'returns an error when passed an invalid group rule id' do
        VCR.use_cassette('groups/invalid_group_rule') do

        end
      end
    end
    describe '#create_group_rule' do
      it 'returns the created group rule when passed valid data' do
        VCR.use_cassette('groups/create_group_rule') do

        end
      end
      it 'returns an error when passed invalid data' do
        VCR.use_cassette('groups/invalid_create_group_rule') do

        end
      end
    end
    describe '#delete_group_rule' do
      it 'returns a 204 when passed a valid group rule id' do
        VCR.use_cassette('groups/delete_group_rule') do

        end
      end
      it 'returns an error when passed an invalid group rule id' do
        VCR.use_cassette('groups/invalid_delete_group_rule') do

        end
      end
      it 'deletes the rule when passed a valid group rule id' do
        VCR.use_cassette('groups/invalid_delete_group_rule') do

        end
      end
    end
    describe '#activate_group_rule' do
      it 'activates the group rule when passed a valid group rule id' do
        VCR.use_cassette('groups/activate_group_rule') do

        end
      end
      it 'returns an error when passed an invalid group rule id' do
        VCR.use_cassette('groups/invalid_activate_group_rule') do

        end
      end
    end
    describe '#deactivate_group_rule' do
      it 'activates the group rule when passed a valid group rule id' do
        VCR.use_cassette('groups/deactivate_group_rule') do

        end
      end
      it 'returns an error when passed an invalid group rule id' do
        VCR.use_cassette('groups/invalid_deactivate_group_rule') do

        end
      end
    end
  end
end
