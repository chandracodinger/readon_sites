class Article < ApplicationRecord
  acts_as_votable
  acts_as_taggable
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :readonuser
  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#", large: "800x800#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
