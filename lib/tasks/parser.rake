namespace :parser do

  require 'open-uri'
  
  desc 'Fetch woow deals'
  task woow: :environment do
    doc = Nokogiri::HTML(open('http://www.woow.com.uy/todas-las-ofertas?ref=m'))
    puts doc
  end

  desc 'All'
  task :all => [:woow]

end
