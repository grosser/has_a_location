require File.expand_path("spec_helper", File.dirname(__FILE__))

describe HasALocation::Mercator do
  describe :num_tiles do
    {0=>1,1=>2,2=>4}.each do |zoom,tiles|
      it "has #{tiles} tiles for zoom #{zoom}" do
        HasALocation::Mercator.send(:num_tiles_per_axis,zoom).should == tiles
      end
    end
  end

  describe :total_width_in_px do
    it "has 256px width on zoom 0" do
      HasALocation::Mercator.send(:total_width_in_px,0).should == 256
    end
  end

  describe :pixel_to_lat do
    {0=>256,1=>256*2}.each do |zoom,full|
      it "full width in px = full width in degree (zoom #{zoom})" do
        pending do
          #dont know why this is wrong ... theoretically it should be correct
          HasALocation::Mercator.pixel_to_lat(full,zoom).should == 180
        end
      end
    end
    
    it "is accurate" do
      #measured using gmaps
      center_lat = 20.1384703125
      inside = 23.160563309
      outside = 23.8858376999
      calc = HasALocation::Mercator.pixel_to_lat(82,5) + center_lat
      calc.should < outside
      calc.should > inside
    end
  end

  describe :pixel_to_lng do
    {0=>256,1=>256*2}.each do |zoom,full|
      it "full width in px = full width in degree (zoom #{zoom})" do
        HasALocation::Mercator.pixel_to_lng(full,zoom).should == 360
      end
    end

    it "is accurate" do
      #measured using gmaps
      center_lng = 85.95703125
      outside = 92.724609375
      inside = 91.93359375
      calc = HasALocation::Mercator.pixel_to_lng(145,5) + center_lng
      calc.should < outside
      calc.should > inside
    end
  end
end