require File.expand_path("spec_helper", File.dirname(__FILE__))

describe HasALocation::MapHelper do
  before do
    @map_size = [290,164]
    @map_zoom = 5
    @map_center = [19.0,86.0]
  end

  describe :latitude_range do
    it "builds" do
      HasALocation::MapHelper.send(:latitude_range,@map_center,@map_size,@map_zoom).should == [15.396484375, 22.603515625]
    end
  end

  describe :longitude_range do
    it "builds" do
      HasALocation::MapHelper.send(:longitude_range,@map_center,@map_size,@map_zoom).should == [79.6279296875, 92.3720703125]
    end
  end
end