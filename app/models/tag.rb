class Tag < ActiveRecord::Base
  has_and_belongs_to_many :places
  validates :name, presence: true
  
  def serializable_hash (options={})
    options = {
      only: [:id, :name],
      methods: [:self_ref]
      }.update(options)
    super(options)
  end
  
  private
  
  def self_ref
    { :link => "#{Rails.configuration.baseurl}#{tag_path(self)}" }
  end
end
