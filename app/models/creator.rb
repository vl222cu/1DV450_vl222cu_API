class Creator < ActiveRecord::Base
  has_many :places
  before_save { self.email = email.downcase }
  
  validates :username, presence: true, length: {maximum: 50}
  validates :password, length: {minimum: 3}
  validates :email, presence: true, uniqueness: true, email_format: { message: "doesn't look like an email address" }
  has_secure_password
  
  def serializable_hash (options={})
    options = {
      only: [:id, :username, :email],
      include: [places: {only: [:name, :text]}],
      methods: [:self_ref, :place_ref]
      }.update(options)
    super(options)
  end
  
  private
  
  def self_ref
    { :link => "#{Rails.configuration.baseurl}#{creator_path(self)}" }
  end
  
  def place_ref
    { :link => "#{Rails.configuration.baseurl}#{place_path(self.place)}" }
  end
end
