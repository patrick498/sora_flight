class NewFlightPosition

  EARTH_RADIUS_KM = 6371.0  # Earth's radius in kilometers

  def initialize(user_lat, user_lon, plane_lat, plane_lon, max_radius)
    @user_lat = user_lat.to_f
    @user_lon = user_lon.to_f
    @plane_lat = plane_lat.to_f
    @plane_lon = plane_lon.to_f
    @max_radius = max_radius.to_f
  end

  # def bring_plane_closer(user_lat, user_lon, plane_lat, plane_lon, max_distance_km)
  def call
    bearing = get_bearing()

    # Limit the distance to max_distance_km
    new_distance_km = [haversine_distance(), @max_radius].min
    delta = new_distance_km / EARTH_RADIUS_KM  # Angular distance in radians

    user_lat_rad = to_radians(@user_lat)
    user_lon_rad = to_radians(@user_lon)
    bearing_rad = to_radians(bearing)

    new_lat_rad = Math.asin(Math.sin(user_lat_rad) * Math.cos(delta) + Math.cos(user_lat_rad) * Math.sin(delta) * Math.cos(bearing_rad))
    new_lon_rad = user_lon_rad + Math.atan2(Math.sin(bearing_rad) * Math.sin(delta) * Math.cos(user_lat_rad), Math.cos(delta) - Math.sin(user_lat_rad) * Math.sin(new_lat_rad))

    {
      lat: to_degrees(new_lat_rad),
      lon: to_degrees(new_lon_rad)
    }
  end

  # Converts degrees to radians
  def to_radians(degrees)
    degrees * Math::PI / 180.0
  end

  # Converts radians to degrees
  def to_degrees(radians)
    radians * 180.0 / Math::PI
  end

  # Calculate the bearing (angle) from (lat1, lon1) to (lat2, lon2)
  def get_bearing()
    lat1_rad = to_radians(@user_lat)
    lat2_rad = to_radians(@plane_lat)
    delta_lon_rad = to_radians(@plane_lon - @user_lon)

    y = Math.sin(delta_lon_rad) * Math.cos(lat2_rad)
    x = Math.cos(lat1_rad) * Math.sin(lat2_rad) - Math.sin(lat1_rad) * Math.cos(lat2_rad) * Math.cos(delta_lon_rad)

    bearing = Math.atan2(y, x)
    (to_degrees(bearing) + 360) % 360  # Normalize to 0-360 degrees
  end

  # Calculate the great-circle distance (Haversine formula)
  def haversine_distance()
    lat1_rad, lon1_rad = to_radians(@user_lat), to_radians(@user_lon)
    lat2_rad, lon2_rad = to_radians(@plane_lat), to_radians(@plane_lon)

    delta_lat = lat2_rad - lat1_rad
    delta_lon = lon2_rad - lon1_rad

    a = Math.sin(delta_lat / 2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(delta_lon / 2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    EARTH_RADIUS_KM * c
  end

end
