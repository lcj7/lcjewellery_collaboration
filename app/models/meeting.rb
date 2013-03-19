class Meeting < ActiveRecord::Base
  attr_accessible :session_ident, :name, :max_size

  validates_numericality_of :max_size, less_than_or_equal_to: 4
  validates :name, length: { maximum: 255 }
end