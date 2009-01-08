class Reference < ActiveRecord::Base
  belongs_to :parent, :class_name => "Card"
  belongs_to :child, :class_name => "Card"
end
