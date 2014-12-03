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

      woow_deal.price = deal.css('p.num-precio')[0].text.to_s.gsub(/\s+/, '')
      woow_deal.saving = deal.css('p.num-porcen')[0].text.to_s.gsub(/\s+/, '')
      woow_deal.bought = deal.css('p.num-comprados')[0].text.to_s.gsub(/\s+/, '')

      woow_deal.page = 'Woow'
      woow_deal.page_reference = 'http://www.woow.com.uy/'

      woow_deal.save!
    end
  end

  desc 'Fetch groupon deals'
  task notelapierdas: :environment do
    doc = Nokogiri::HTML(open('http://www.notelapierdas.com.uy/'))
    deals = doc.css('li.item.small')
    
    deals.each do |deal|

      ntlp_deal = Deal.new
      
      ntlp_deal.title = deal.css('div.deal-title_small').css('h2').text.gsub(/\s{2,}/, '')

      tag_a = deal.css('div.deal_product_image').css('div.media').css('a')[0]
      ntlp_deal.reference = tag_a['href']
      ntlp_deal.photo = tag_a.css('img')[0]['src']

      ntlp_deal.info1 = deal.css('div.deal-desc').css('p').text.gsub(/\s{2,}/, '')

      prices_string = deal.css('div.amount_small').text.to_s.gsub(/\s/, '')
      if prices_string.include? 'U$S'
        ntlp_deal.dolars = true
      else
        ntlp_deal.dolars = false
      end
      prices_array = prices_string.gsub('.', '').scan(/\d+/)
      ntlp_deal.price = prices_array.last
      if prices_array.length == 2
        ntlp_deal.old_price = prices_array.first
      end

      ntlp_deal.saving = deal.css('div.porcentaje_ahorro').text.to_s.gsub(/\s+/, '').gsub(/-/, '')

      ntlp_deal.page = 'No te la pierdas'
      ntlp_deal.page_reference = 'http://www.notelapierdas.com.uy/'

      ntlp_deal.save!
    end
  end

  desc 'Fetch woow json deals'
  task woow_json: :environment do

    links = [ 'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?both=1&limit=1000&show=0&section_id=163', #travel
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?date=2014-12-01&date_type=1&both=0&limit=1000&show=0&section_id=165', #estetica y bien estar
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?date=2014-12-01&date_type=1&both=0&limit=1000&show=0&section_id=166', #restaurantes
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?both=1&order=popularidad&limit=1000&show=0&section_id=167', #ofertas del dia
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?both=1&order=popularidad&limit=1000&show=0&section_id=181', #Shopping de Productos Tecnología
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?both=1&order=popularidad&limit=1000&show=0&section_id=187', #Shopping de Productos Muebles
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?both=1&order=popularidad&limit=1000&show=0&section_id=186', #Shopping de Productos Hogar
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?both=1&order=popularidad&limit=1000&show=0&section_id=185', #Shopping de Productos Hogar
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?both=1&order=popularidad&limit=32&show=32&section_id=184', #Shopping de Productos Aire libre
            'http://www.woow.com.uy/frontend/magic_enrutator/get_filtered_offer_boxes?both=1&order=popularidad&limit=1000&show=0&section_id=415' #shopping de productos outlet
          ]

    links.each do |link|

      result = JSON.parse(open(link).read)
      
      deals = result['offers']


      deals.each do |deal|

        woow_deal = Deal.new
        
        woow_deal.title = deal['name']

        woow_deal.reference = deal['link']
        woow_deal.photo = deal['imgsource']

        woow_deal.info1 = deal['small_description_1']
        woow_deal.info2 = deal['small_description_2']

        woow_deal.saving = deal['discount']
        woow_deal.bought = deal['coupons_bought']
        deal['currency'] == 'U$S' ? woow_deal.dolars = true : woow_deal.dolars = false
        
        if deal['currency'] == 'U$S'
          woow_deal.price = deal['coupon_price_usd'].scan(/\d+/).first if deal['coupon_price_usd'].present?
        else
          woow_deal.price = deal['coupon_price'].scan(/\d+/).first if deal['coupon_price'].present?
        end

        if  deal['currency'] == 'U$S'
          woow_deal.old_price = deal['ordinary_price_usd'].scan(/\d+/).first if deal['ordinary_price_usd'].present?
        else
          woow_deal.old_price = deal['ordinary_price'].scan(/\d+/).first if deal['ordinary_price'].present?
        end

        woow_deal.page = 'WooW'
        woow_deal.page_reference = 'http://www.woow.com.uy/'

        woow_deal.save!
      end
    end

  end


  desc 'All'
  task :all => [:woow_json, :notelapierdas]

end
