# frozen_string_literal: true

require 'simpleokta/version'
require 'simpleokta/client'
require 'faraday'

# @author Braden Shipley
module Simpleokta
  def self.new(*args)
    Simpleokta::Client.new(*args)
  end
end
