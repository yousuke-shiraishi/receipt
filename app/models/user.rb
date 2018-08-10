class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers:  %i(google facebook)

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  before_save { email.downcase! }
#  validates :password, presence: true, length: { minimum: 6 } ,on: :create
  has_many :favorites, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture

  has_many :pictures
  mount_uploader :image, ImageUploader
  def self.create_unique_string
    SecureRandom.uuid
  end
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(email: auth.info.email,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20],
                                 )
    end
    user.save
    user
  end
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.find_by(provider: auth.provider, uid: auth.uid)

  unless user
    user = User.new(provider: auth.provider,
                    uid:      auth.uid,
                    email:    "#{auth.uid}-#{auth.provider}@example.com",
                    password: Devise.friendly_token[0, 20]
    )
  end
  user.save
  user
end
end
