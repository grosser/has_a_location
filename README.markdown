GOALS
=====
 - add a location to your models (latitude/longitude)
 - find other models in a certain radius
 - prevent assignment of a default location (some value your maps script uses as starting point)


INSTALL
=======

    script/plugin install git://github.com/ptb/geokit.git
    script/plugin install git://github.com/grosser/has_a_location.git

Table with (see: MIGRATION):

    lat
    lng

Model:

    User < ActiveRecord::Base
      has_a_location :default_location_lat=>10.10,:default_location_lng=>20.20
    end
 
USAGE
=====
 - `user.location = [12.2332,323.2323]`
 - `user.in_radius(500)` => users in 500 miles distance
 - `show_map if user.location`
 - other options:


    Legend: options key => default [recommended]
    :default_units => :miles [:kms]
    :default_formula => :sphere [:flat]
    :lat_column_name=>:lat [:location_latitude]
    :lng_column_name=>:lng [:location_longitude]
    :distance_column_name=>:distance [:distance]
 

AUTHOR
======
  Michael Grosser  
  grosser dot michael ät gmail dot com  