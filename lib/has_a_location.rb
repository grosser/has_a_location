module HasALocation
  def self.included(base) #:nodoc:
    base.extend ClassMethods
  end
  
  module ClassMethods
    def has_a_location(options={})
      return if self.included_modules.include?(HasALocation::InstanceMethods)
      
      #store our own defaults
      cattr_accessor :default_location_lat,:default_location_lng
      self.default_location_lng = options.delete(:default_location_lng) || 0
      self.default_location_lat = options.delete(:default_location_lat) || 0
      
      #give everything else to acts_as_mappable
      acts_as_mappable options
        
      before_save :remove_default_location
      
      include HasALocation::InstanceMethods
    end
  end
  
  module InstanceMethods
    def location
      lat,lng = send(self.class.lat_column_name), send(self.class.lng_column_name) 
      return unless lat and lng 
      [lat,lng]
    end
    
    def location=(val)
      if val
        raise unless val.kind_of?(Array) and val.size == 2
        send(self.class.lat_column_name.to_s+'=',val[0])
        send(self.class.lng_column_name.to_s+'=',val[1])
      else
        send(self.class.lat_column_name.to_s+'=',nil)
        send(self.class.lng_column_name.to_s+'=',nil)
      end
    end
    
    def in_radius(distance)
      return [] unless location 
      self.class.find(:all, :origin => location, :conditions => ["#{self.class.distance_column_name} < ? AND id != ?",distance,id]) 
    end
    
  protected
  
    def remove_default_location
      def_lat = send(self.class.lat_column_name).to_f.round(6) == self.class.default_location_lat.to_f.round(6)
      def_lng = send(self.class.lng_column_name).to_f.round(6) == self.class.default_location_lng.to_f.round(6)
      self.location = nil if def_lat and def_lng 
    end
    
  end
  
  
end