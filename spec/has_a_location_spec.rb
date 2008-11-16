require File.expand_path("spec_helper", File.dirname(__FILE__))

describe HasALocation do
  before do
    @user = User.new
  end
  
  describe :remove_default_location do
    it "does not store the default location" do
      @user.location_latitude = User.default_location_lat
      @user.location_longitude = User.default_location_lng
      @user.save
      @user.location_latitude.should be_nil
      @user.location_longitude.should be_nil
    end
  end
  
  describe :location do
    it "has location" do
      User.new(:location_latitude=>1,:location_longitude=>2).location.map(&:to_i).should == [1,2]
    end
    
    it "has no location if location fields are nil" do
      User.new().location.should be_nil
    end
  end
  
  describe :location= do
    before do
      @user.location_latitude = 3
      @user.location_longitude = 4
    end
  
    it "can set the location" do
      @user.location=[1,2]
      @user.location_latitude.should == 1
      @user.location_longitude.should == 2
    end
    
    it "can unset the location" do
      @user.location=nil
      @user.location_latitude.should be_nil
      @user.location_longitude.should be_nil
    end
  end
  
  describe :in_radius do
    before do
      @user.location = [1,1]
    end
    
    it "finds using origin" do
      @user.save
      User.expects(:find).with(:all, :origin => [1,1], :conditions => ["distance < ? AND id != ?",10,@user.id])
      @user.in_radius(10)
    end
    
    it "does not find if location is nil" do
      @user.location = nil
      @user.in_radius(10).should == []
    end
  end

  describe :on_map do
    before do
      @map_size = [290,164]
      @map_zoom = 5
      @map_center = [19.0,86.0]

      User.delete_all
      #somewhere in india, center + 1 in NE corner of the map + 1 in SW corner of the map
      @user_in_center = User.create!(:location=>@map_center)
      @on_map = [
        User.create!(:location=>[21.6982654969,89.118359375]),#NE
        User.create!(:location=>[17.1407903933,82.9337890625])#SW
      ]
      #4 locations outside the map in N/S/E/W
      @off_map = [
        User.create!(:location=>[23.1201536217,82.08984375]),#N
        User.create!(:location=>[14.4346802153,87.5390625]),#S
        User.create!(:location=>[21.6982654969,93.076171875]),#E
        User.create!(:location=>[21.4121622297,79.013671875])#W
      ]
    end

    it "finds all on map, expludes off map, excludes self" do
      User.on_map(@map_center,@map_size,@map_zoom).to_a.map(&:id).should == [@user_in_center.id]+@on_map.map(&:id)
    end

    it "finds all on map, expludes off map, excludes self" do
      @user_in_center.surrounding_on_map(@map_size,@map_zoom).to_a.map(&:id).should == @on_map.map(&:id)
    end

    it "does not alter given parameters" do
      a=[1,2]
      b=[3,4]
      c=3
      User.on_map(a,b,c)
      a.should == [1,2]
      b.should == [3,4]
      c.should == 3
    end
  end
end