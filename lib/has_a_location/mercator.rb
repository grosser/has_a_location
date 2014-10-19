module HasALocation
  # Mercator-projection is basis for GMaps calculations
  class Mercator
    # GMaps is based on tiles
    # one tile is 256px x 256px
    TILE_SIZE = 256

    # 180 degrees of latitude
    #FIXME as far as i understand this should work without * 2
    def self.pixel_to_lat(pixel,zoom)
      pixel * 180.0 / total_width_in_px(zoom) * 2
    end

    # 360 degrees of longitude
    def self.pixel_to_lng(pixel,zoom)
      pixel * 360.0 / total_width_in_px(zoom)
    end

  private

    def self.total_width_in_px(zoom)
      num_tiles_per_axis(zoom) * TILE_SIZE
    end

    # zoom 0 = 1 tile (256x256)
    # zoom 1 = 4 tiles (= 512x512)
    def self.num_tiles_per_axis(zoom)
      2 ** zoom
    end
  end
end