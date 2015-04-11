module Parsers
    class EarthquakeParser
        START_ROW=1
        SHEET_POSITION = 1
        DEFAULT_FILE_NAME = 'Mag6PlusEarthquakes_1900-2013.xlsx'

        def self.process(filename = Rails.root.join('lib','assets',DEFAULT_FILE_NAME), display = false)
            sheet = Utils::GenericUtils.get_sheet(filename,SHEET_POSITION)
            total_rows = sheet.rows.count
            (START_ROW..total_rows).each do |row_number|
                row_array = sheet.rows[row_number]

                unless row_array.nil? || row_array[0].blank?
                    if display
                        puts row_array.to_s
                    else
                        time_stamp  = Utils::GenericUtils.scrub_date(row_array[0])
                        time_of_day = Utils::GenericUtils.scrub_time(row_array[2])
                        latitude    = Utils::GenericUtils.scrub(row_array[3],4)
                        longitude   = Utils::GenericUtils.scrub(row_array[4],4)
                        depth       = Utils::GenericUtils.scrub(row_array[5],2)
                        mag         = Utils::GenericUtils.scrub(row_array[6],1)
                        mag_type    = row_array[7]
                        nst         = row_array[8].to_i
                        gap         = Utils::GenericUtils.scrub(row_array[9],1)
                        dmin        = Utils::GenericUtils.scrub(row_array[10],7)
                        rms         = Utils::GenericUtils.scrub(row_array[11],6)
                        net         = row_array[12]
                        quake_identifier= row_array[13]
                        updated     = Utils::GenericUtils.scrub_date(row_array[14])
                        place       = row_array[15]
                        quake_type  = row_array[16]

                        unless time_stamp.blank?
                            Earthquake.where(quake_identifier: quake_identifier).first_or_create do |quake_obj|
                                                quake_obj.time_stamp    = time_stamp
                                                quake_obj.time_of_day   = time_of_day
                                                quake_obj.latitude      = latitude
                                                quake_obj.longitude     = longitude
                                                quake_obj.depth         = depth
                                                quake_obj.mag           = mag
                                                quake_obj.mag_type      = mag_type
                                                quake_obj.nst           = nst
                                                quake_obj.gap           = gap
                                                quake_obj.dmin          = dmin
                                                quake_obj.rms           = rms
                                                quake_obj.net           = net
                                                quake_obj.updated       = updated
                                                quake_obj.place         = place
                                                quake_obj.quake_type    = quake_type
                            end
                        end
                    end
                end
            end
        end
    end
end

# t.datetime :time_stamp
# t.time :time_of_day
# t.decimal :latitude, precision: 7, scale: 4
# t.decimal :longitude, precision: 7, scale: 4
# t.decimal :depth, precision: 5, scale: 2
# t.decimal :mag, precision: 2, scale: 1
# t.string :mag_type
# t.integer :nst
# t.decimal :gap, precision: 4, scale: 1
# t.decimal :dmin, precision: 10, scale: 7
# t.decimal :rms, precision: 8, scale: 6
# t.string :net
# t.string :quake_identifier
# t.datetime :updated
# t.string :place
# t.string :quake_type