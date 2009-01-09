class TransclusionChunk < Chunk

  JOINT = "+"
  TRANSCLUDE_PATTERN = /\{\{((#{'\\'+JOINT})?[^\|]+?)\s*(\|([^\}]+?))?\}\}/
    
  def self.pattern
    TRANSCLUDE_PATTERN
  end

  def initialize(base_card, match, content)
    @base_card = base_card
    @card_name, @options = parse(match)
    @absolute_name = to_absolute(@base_card.name)
    @card = Card.get @absolute_name
    
    if @card
      @ref_type = "Transclusion"
    else
      @ref_type = "TransclusionWanted"
    end
    
  end
  
  def unmask
    if @card
      @card.render
    else
      %{<a class="wanted-card" href="/cards/#{@absolute_name}">Add #{@card_name}</a>}
    end
  end
  
  def to_s
    [@card_name, "Transclusion"].join ":"
  end

  def parse(match)
    name = match[1].strip
    relative = match[2]
    options = {}
    [name, options]
  end

end