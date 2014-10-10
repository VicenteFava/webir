namespace :parser do

  require 'open-uri'
  
  desc 'Fetch woow deals'
  task woow: :environment do
    doc = Nokogiri::HTML(open('http://www.woow.com.uy/todas-las-ofertas?ref=m'))
    deals = doc.css('div.lista-item')

    deals.each do |deal|

      woow_deal = Deal.new

      woow_deal.title = deal.css('a')[0].css('h3').to_s.scan(/\>([^\]]*)\</).flatten[0]

      tag_a = deal.css('a')[1]
      woow_deal.reference = tag_a['href']
      woow_deal.photo = tag_a.css('div')[0]['style'].to_s.scan(/\'([^\]]*)\'/).flatten[0]
      
      info = deal.css('article')[0].css('p')
      woow_deal.info1 = info[0].to_s.scan(/\>([^\]]*)\</).flatten[0]
      woow_deal.info2 = info[1].to_s.scan(/\>([^\]]*)\</).flatten[0]

      woow_deal.price = deal.css('p.num-precio')[0].text.to_s.gsub(/\s+/, "")
      woow_deal.saving = deal.css('p.num-porcen')[0].text.to_s.gsub(/\s+/, "")
      woow_deal.bought = deal.css('p.num-comprados')[0].text.to_s.gsub(/\s+/, "")

      woow_deal.page = 'Woow'
      woow_deal.page_reference = 'http://www.woow.com.uy/'

      woow_deal.save!
    end
  end

  desc 'All'
  task :all => [:woow]

end
