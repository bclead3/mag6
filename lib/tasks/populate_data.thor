class PopulateData < Thor

  desc 'process', 'Reads Excel data and populates earthquakes table.'
  def process
    require File.expand_path('config/environment.rb')

    Parsers::EarthquakeParser.process
    puts "Processed #{Earthquake.count} rows into the database."
  end

  desc 'report', 'Creates old-style (.xls) Excel report of top 100 earthquakes.'
  def report
    require File.expand_path('config/environment.rb')

    Reports::TopEarthquakes.write_xls
    puts 'Look for the TopEarthquakes.xls file in the project root.'
  end
end
