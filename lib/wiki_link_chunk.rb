class WikiLinkChunk < Chunk
  
  word = /\s*([^\]\|]+)\s*/
  WIKI_LINK = /\[\[#{word}(\|#{word})?\]\]|\[#{word}\]\[#{word}\]/
  
  
  def self.pattern
    WIKI_LINK
  end   

  def initialize(base_card, match_data, content)
    @base_card = base_card
    
    if @card_name = match_data[1]
      @link_text = match_data[  match_data[2] ? 3 : 1 ]
    else
      @link_text = match_data[4]
      @card_name = match_data[5]  #.gsub(/_/,' ')
    end
    
    @absolute_name = to_absolute(@base_card.name)
    @card = Card.get @absolute_name
    
    if @card
      @ref_type = "Link"
    else
      @ref_type = "LinkWanted"
    end
    
  end
  
  def to_s
    [@card_name, @ref_type].join ":"
  end

  def unmask
    href = @card_name
    klass = 
    case href
    when /^\//; 'internal-link'
    when /^https?:/; 'external-link'
    when /^mailto:/; 'email-link'
    else 
      if @card
        href = "/cards/" + @absolute_name
        'known-card'
      else
        href = "/cards/" + @absolute_name
        'wanted-card'
      end
    end
    %{<a class="#{klass}" href="#{href}">#{@link_text}</a>}
  end
  
end