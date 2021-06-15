# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'dotenv'
require 'dotenv/tasks'

RSpec::Core::RakeTask.new(:spec)
Dotenv.load('.env')

task default: :spec
