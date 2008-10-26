require 'rubygems'
require 'active_record'
require 'active_record/fixtures'

#create model table
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.decimal  :location_latitude,  :precision => 13, :scale => 10
    t.decimal  :location_longitude, :precision => 13, :scale => 10
    t.timestamps
  end
end

#create model
class User < ActiveRecord::Base
  def self.acts_as_mappable(options)
    #cannot test this :<
  end
  
  #fake acts_as_mappable
  def self.lng_column_name;'location_longitude';end
  def self.lat_column_name;'location_latitude';end
  def self.distance_column_name;'distance';end
    
  has_a_location :default_units => :kms, :default_formula => :flat,
    :lat_column_name=>:location_latitude,:lng_column_name=>:location_longitude,
    :default_location_lat=>10.10,:default_location_lng=>20.20
end