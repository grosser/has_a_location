require File.expand_path("spec_helper", File.dirname(__FILE__))

describe "has a location" do
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
  
end