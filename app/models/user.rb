class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :profile_image

  validates :name, presence:true, length: { in: 2..20 }

  def self.looks(searches, words)
    if searches == "perfect_match"
      @user = User.where("name LIKE ?", "#{words}")
    elsif searches == "partial_match"
      @user = User.where("name LIKE ?", "%#{words}%")
    elsif searches == "forward_match"
      @user = User.where("name LIKE ?", "#{words}%")
    elsif searches == "backward_match"
      @user = User.where("name LIKE ?", "%#{words}")
    end
  end
end
