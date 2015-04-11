module Reports
    class TopEarthquakes
        def self.write_xls(filename = "TopEarthquakes.xls")
            top_earthquakes = Earthquake.order('mag DESC').limit(100)

            book = Utils::GenericUtils.create_workbook_from_file(filename)
            sheet = book.add_worksheet('Top Quakes')

            sheet.set_column(0, 0, 25)
            sheet.set_column(1, 8, 40)
            sheet.set_column(2, 8, 7)

            heading_format = book.add_format(:align => 'center', :bold => 1)
            number_format = book.add_format
            number_format.set_num_format(Utils::GenericUtils.get_numeric_formats[0][0])

            sheet.write(0, 0, "Top Earthquakes by Magnitude", heading_format)

            running_index = 2
            top_earthquakes.each_with_index do |quake, idx|
                sheet.write(idx+2,0, (idx+1))
                sheet.write(idx+2,1, quake.place)
                sheet.write(idx+2,2, quake.mag, number_format)
                running_index += 1
            end

            book.close
        end
    end
end