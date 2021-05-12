# -*- encoding: utf-8 -*-
# stub: breakers 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "breakers".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aubrey Holland".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-10-13"
  s.description = "This is a Faraday middleware that detects backend outages and reacts to them".freeze
  s.email = ["aubrey@adhocteam.us".freeze]
  s.homepage = "https://github.com/department-of-veterans-affairs/breakers".freeze
  s.licenses = ["CC0-1.0".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Handle outages to backend systems with a Faraday middleware".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<faraday>.freeze, [">= 0.7.4", "< 0.18"])
    s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<byebug>.freeze, ["~> 9.0"])
    s.add_development_dependency(%q<fakeredis>.freeze, ["~> 0.6.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 11.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["= 0.43.0"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.12.0"])
    s.add_development_dependency(%q<timecop>.freeze, ["~> 0.8.0"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 2.1"])
  else
    s.add_dependency(%q<faraday>.freeze, [">= 0.7.4", "< 0.18"])
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<byebug>.freeze, ["~> 9.0"])
    s.add_dependency(%q<fakeredis>.freeze, ["~> 0.6.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 11.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.43.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.12.0"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.8.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 2.1"])
  end
end
