# -*- encoding: utf-8 -*-
# stub: faraday 0.7.6 ruby lib

Gem::Specification.new do |s|
  s.name = "faraday".freeze
  s.version = "0.7.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Rick Olson".freeze]
  s.date = "2012-01-21"
  s.description = "HTTP/REST API client library.".freeze
  s.email = "technoweenie@gmail.com".freeze
  s.homepage = "http://github.com/technoweenie/faraday".freeze
  s.rubygems_version = "3.1.4".freeze
  s.summary = "HTTP/REST API client library.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.2"])
    s.add_runtime_dependency(%q<multipart-post>.freeze, ["~> 1.1"])
    s.add_runtime_dependency(%q<rack>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
  else
    s.add_dependency(%q<addressable>.freeze, ["~> 2.2"])
    s.add_dependency(%q<multipart-post>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rack>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
  end
end
