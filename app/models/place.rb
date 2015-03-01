class Place < ActiveRecord::Base
  belongs_to :creator
  has_and_belongs_to_many :tags
  # Given a place with known laititude/longitude coordinates
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
 
  validates :name, presence: true
  validates :text, presence: true
  
  def serializable_hash (options={})
    options = {
      only: [:id, :name, :text, :longitude, :latitude, :address],
      include: [:tags],
      #methods: [:self_ref, :creator_ref]
      }.update(options)     
    super(options)
  end
  
  def self_ref
    { :link => "#{Rails.configuration.baseurl}#{place_path(self)}" }
  end
  
  def creator_ref
    { :link => "#{Rails.configuration.baseurl}#{creator_path(self.creator)}" }
  end
  
end
