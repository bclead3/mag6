json.array!(@earthquakes) do |earthquake|
  json.extract! earthquake, :id, :time_stamp, :time_of_day, :latitude, :longitude, :depth, :mag, :mag_type, :nst, :gap, :dmin, :rms, :net, :quake_identifier, :updated, :place, :quake_type
  json.url earthquake_url(earthquake, format: :json)
end
