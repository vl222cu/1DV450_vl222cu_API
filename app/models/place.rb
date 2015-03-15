class Place < ActiveRecord::Base
  belongs_to :creator
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
  
  # Given a place with known laititude/longitude coordinates
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
 
  validates :name, presence: true
  validates :text, presence: true
  
  # Sorting places in desc order
  scope :latest, -> {order(updated_at: :desc)}
  
  def serializable_hash (options={})
    options = {
      only: [:id, :name, :text, :longitude, :latitude, :address],
      include: [:tags],
      methods: [:self_ref, :creator_ref]
      }.update(options)     
    super(options)
  end
  
  def self_ref
    { :link => "#{Rails.configuration.baseurl}#{Rails.application.routes.url_helpers.place_path(self)}" }
  end 

def creator_ref
  creator = self.creator
  { 
    :username => creator.username,
    :creatorid => creator.id,
    :link => "#{Rails.configuration.baseurl}#{Rails.application.routes.url_helpers.creator_path(creator)}" 
  }
  end
end
