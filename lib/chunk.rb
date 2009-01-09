class Chunk
  
  attr_reader :ref_type, :card, :absolute_name
  
  def to_absolute(context_name)
    @card_name.
    gsub(/_self|_whole/, context_name).
    gsub(/\s*\+$/, '+' + context_name).
    gsub(/^\+\s*/, context_name + '+')
  end
  
end