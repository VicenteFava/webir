namespace :parser do

  require 'open-uri'
  
  desc 'Fetch woow deals'
  task woow: :environment do
    doc = Nokogiri::HTML(open('http://www.woow.com.uy/todas-las-ofertas?ref=m'))
    deals = doc.css('div.lista-item')

    deals.each do |deal|

      title = deal.css('a')[0].css('h3').to_s.scan(/\>([^\]]*)\</)

      tag_a = deal.css('a')[1]
      ref = tag_a['href']
      photo = tag_a.css('div')[0]['style'].to_s.scan(/\'([^\]]*)\'/)
      
      info = deal.css('article')[0].css('p')
      info1 = info[0].to_s.scan(/\>([^\]]*)\</)
      info2 = info[1].to_s.scan(/\>([^\]]*)\</)

      precio = deal.css('p.num-precio')[0].text.to_s.gsub(/\s+/, "")
      ahorro = deal.css('p.num-porcen')[0].text.to_s.gsub(/\s+/, "")
      comprados = deal.css('p.num-comprados')[0].text.to_s.gsub(/\s+/, "")

      #guardar en la base

      puts ref
      puts photo
      puts title
      puts info1
      puts info2
      puts precio
      puts ahorro
      puts comprados

    end
  end

  desc 'All'
  task :all => [:woow]

end


# <div class="lista-item">
#       <div class="lista-item-top"></div>
#         <div class="lista-item-body">
#           <a href="http://www.woow.com.uy/oferta/2014/05/27/buenos_aires_por_seacat_-_2_noches_orly_fecha_a_eleccion">
#             <h3>Buenos Aires por Seacat - 2 noches Orly Fecha a eleccion</h3>
#           </a>
#           <figure>
#             <a href="http://www.woow.com.uy/oferta/2014/05/27/buenos_aires_por_seacat_-_2_noches_orly_fecha_a_eleccion">
#               <div style="width: 204px;
#               height: 102px; 
#               background-position: center;
#               background-repeat: no-repeat; 
#               background-size: cover; 
#               background-image: url('https://68b70847b87fa4ca414b-2a9b9aa40f6a1fb4934d31fcacd61214.ssl.cf2.rackcdn.com/c0/b4/c0b4e8abbfceaf011dd8cdcda1fa2eac_204x102.jpg');"> </div>           </a>
#           </figure>
#           <article class="trece-pts article-all-deals">
#             <p>¡Elegí fecha y horario a tu gusto!</p>
#             <p>2 noches + desayuno</p>
#           </article>
#           <div class="num listado-num">
#             <div class="num-precio">
#               <p class="num-precio"><u>u$s</u>129</p>
#               <p class="num-ref">precio</p>
#             </div>
#             <div class="num-porcen">
#               <p class="num-porcen">0<u>%</u></p>
#               <p class="num-ref">ahorro</p>
#             </div>
#             <div class="num-comprados">
#               <p class="num-comprados">
#                                   524   </p>
#               <p class="num-ref">comprados</p>
#             </div>
#           </div>
#           <div class="comprar listado-comprar right">
#             <div class="comprar-precio">
#               <p><u>u$s</u>129</p>
#             </div>
#             <div class="comprar-action comprar-action-animation">
#               <p><a href="http://www.woow.com.uy/oferta/2014/05/27/buenos_aires_por_seacat_-_2_noches_orly_fecha_a_eleccion">Ver Oferta</a></p>
#             </div>
#           </div>
#         </div>
#       <div class="lista-item-bot"></div>
#     </div>
