class CreateEarthquakes < ActiveRecord::Migration
  def change
    create_table :earthquakes do |t|
      t.datetime :time_stamp
      t.time :time_of_day
      t.decimal :latitude, precision: 7, scale: 4
      t.decimal :longitude, precision: 7, scale: 4
      t.decimal :depth, precision: 5, scale: 2
      t.decimal :mag, precision: 2, scale: 1
      t.string :mag_type
      t.integer :nst
      t.decimal :gap, precision: 4, scale: 1
      t.decimal :dmin, precision: 10, scale: 7
      t.decimal :rms, precision: 8, scale: 6
      t.string :net
      t.string :quake_identifier
      t.datetime :updated
      t.string :place
      t.string :quake_type

      t.timestamps null: false
    end
  end
end
