class DistanceTwoPoints

  EARTH_RADIUS_KM = 6371.0

  def initialize(lat1, lon1, lat2, lon2)
    @lat1 = lat1.to_f
    @lat2 = lat2.to_f
    @lon1 = lon1.to_f
    @lon2 = lon2.to_f
  end

  def call
    haversine_distance
  end

  def to_radians(degrees)
    degrees * Math::PI / 180.0
  end

  def haversine_distance()
    lat1_rad, lon1_rad = to_radians(@lat1), to_radians(@lon1)
    lat2_rad, lon2_rad = to_radians(@lat2), to_radians(@lon2)

    delta_lat = lat2_rad - lat1_rad
    delta_lon = lon2_rad - lon1_rad

    a = Math.sin(delta_lat / 2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(delta_lon / 2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    EARTH_RADIUS_KM * c
  end
end
