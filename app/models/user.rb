class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable



  after_discard :discard_profile
  after_undiscard :undiscard_profile

  def discard_profile
    profile.discard if profile.present?
  end
      
  def undiscard_profile
    profile.undiscard if profile.present?
  end
end
