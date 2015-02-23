class Place < ActiveRecord::Base
  belongs_to :creator
  has_and_belongs_to_many :tags
 
  validates :name, presence: true
  validates :text, presence: true
end
