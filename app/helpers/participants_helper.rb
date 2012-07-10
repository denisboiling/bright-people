# Please fix this shit, I'm a Ruby noob
# I'm so sorry :(

module ParticipantsHelper
  def participants_menu (links) 
    
    html = '<ul class="participants_menu">'
    
    links.each do |item|
      
      html += '<li>'
      
      raw <<-HTML
      <li>
      HTML
      
      if ( item['link'] == request.params['category'] )
        html += link_to item['title'], participants_path(category: item['link']), :class => 'active'
      else
        html += link_to item['title'], participants_path(category: item['link'])
      end
      
      html += '</li>'
    end
    
    html += '</ul>'
    
    raw html
  end
end