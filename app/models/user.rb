class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_attached_file :profile_picture
  validates_attachment :profile_picture,
    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
  validates :name, :email, :role, presence: true

  ROLES = %w[admin user]

  def admin?
    role.zero?
  end

  def user?
    role == 1
  end

  def role=(value)
    value ||= 1
    super(value)
  end
end
