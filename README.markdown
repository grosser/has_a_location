Features
========
 - add a location to your models (latitude/longitude)
 - find other models in a certain radius
 - find other models on the same map (giving map size in pixels and zoom level)
 - prevent assignment of a default location (value your map script uses as default/starting point)


INSTALL
=======

```Bash
gem i has_a_location
```

Table with (see: MIGRATION):

```
lat
lng
```

Model:

```Ruby
User < ActiveRecord::Base
  has_a_location default_location_lat: 10.10, default_location_lng: 20.20
end
```


USAGE
=====
 - `user.location = [12.2332,323.2323]` [latitude,longitude]
 - `show_map if user.location`
 - `user.in_radius(500)` => users in 500 miles distance
 - `User.on_map([11.12343,34,183323],[640,480],5)` => all users visible on a 640x480 map zoom-level 5, with center 11.12343,34,183323
 - `user.surrounding_on_map([640,480],5)` => other users visible on this map


OPTIONS
=======

    Legend: options key => default [recommended]
    default_location_lng: 0 [your default map longitude]
    default_location_lat: 0 [your default map latitude]
    default_units: :miles [:kms]
    default_formula: :sphere [:flat]
    lat_column_name: :lat [:location_latitude]
    lng_column_name: :lng [:location_longitude]
    distance_column_name: :distance [:distance]


TODO
====
 - latitude calculation is theoretically (wrong theory?) wrong put works practically...


AUTHOR
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/parallel.png)](https://travis-ci.org/grosser/parallel)
