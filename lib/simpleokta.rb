require "simpleokta/version"
require "simpleokta/configuration"
require "faraday"

# @author Braden Shipley
module Simpleokta
  extend self
  attr_accessor :configuration

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Error < StandardError; end
end
