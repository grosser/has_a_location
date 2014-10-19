# ---- requirements
require 'has_a_location'

# ---- load database
RAILS_ENV = "test"
ActiveRecord::Base.configurations = {"test" => {
  :adapter => "sqlite3",
  :database => ":memory:",
}.with_indifferent_access}

ActiveRecord::Base.establish_connection(:test)


# ---- setup environment/plugin
load File.expand_path("setup_test_model.rb", File.dirname(__FILE__))
