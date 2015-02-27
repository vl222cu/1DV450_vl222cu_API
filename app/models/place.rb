class Place < ActiveRecord::Base
  belongs_to :creator
  has_and_belongs_to_many :tags
 
  validates :name, presence: true
  validates :text, presence: true
  
  def serializable_hash (options={})
    options = {
      only: [:id, :name, :text, :longitude, :latitude],
      include: [creators: {only: [:username, :email]}, tags: {only: [:name]}]
      methods: [:self_ref, :creator_ref]
      }.update(options)    
    super(options)
  end
  
  private
  
  def self_ref
    { :link => "#{Rails.configuration.baseurl}#{place_path(self)}" }
  end
  
  def creator_ref
    { :link => "#{Rails.configuration.baseurl}#{creator_path(self.creator)}" }
  end
  
end
