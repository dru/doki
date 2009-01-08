class Card < ActiveRecord::Base
  
  has_many :references, :foreign_key => "parent_id", :class_name => "Reference"
  has_many :referencee, :foreign_key => "child_id", :class_name => "Reference"
  
  validates_uniqueness_of :name, :on => :create
  
  after_save :update_wanted_references
  
  def render
    ""
  end
  
  def self.get name
    self.find_by_name name
  end
  
  def self.get_without_sti name
    self.find_by_sql(["select *, 'Card' as type from cards where name = ?", name]).first
  end
  
  def to_param
    name
  end
  
  def update_wanted_references
    Reference.update_all("reference_type = 'Link', child_id=#{id}",  ['reference_card_name = ? and reference_type=?', name, 'LinkWanted'])
    Reference.update_all("reference_type = 'Transclusion', child_id=#{id}",  ['reference_card_name = ? and reference_type=?', name, 'TransclusionWanted'])
  end
  
end
