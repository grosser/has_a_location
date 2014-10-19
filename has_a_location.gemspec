name = "has_a_location"
require "./lib/#{name}/version"

Gem::Specification.new name, HasALocation::VERSION do |s|
  s.summary = "Locations for your models"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files lib`.split("\n")
  s.license = "MIT"
  s.add_runtime_dependency "activerecord"
  s.add_runtime_dependency "geokit"
end
