class Readonuser < ApplicationRecord
  acts_as_voter
  has_many :articles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, authentication_keys: [:login]
 
 validates :username, presence: :true, uniqueness: { case_sensitive: false }
  attr_accessor :login

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "200x200#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    if conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end
end


end
