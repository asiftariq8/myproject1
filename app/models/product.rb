class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  has_many :wishlists, dependent: :destroy
  has_many :wishlisted_by, through: :wishlists, source: :user
  has_many :comments, dependent: :destroy
 
  enum category: { electronics: 0, grocery: 1, clothes: 2, sports: 3 }

  validates :name, :price, :description, :category, presence: true
  validates :serial_number, uniqueness: true

  before_validation :assign_serial_number, on: :create
  

  private

  def assign_serial_number
    self.serial_number ||= "PRD-#{SecureRandom.uuid[0..7].upcase}"
  end

end
