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

  #search

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

  #follow

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships,  class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end


end
