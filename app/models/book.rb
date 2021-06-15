class Book < ApplicationRecord
	validates :title, presence: true
	validates :body, presence: true
	belongs_to :user
	has_many :favorites, dependent: :destroy

  validates :body, length: { maximum: 200 }

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.looks(searches, words)
		if searches == "perfect_match"
			@post = Book.where("title LIKE ?", "#{words}")
		elsif searches == "partial_match"
      @post = Book.where("title LIKE ?", "%#{words}%")
    elsif searches == "forward_match"
      @post = Book.where("title LIKE ?", "#{words}%")
    elsif searches == "backward_match"
      @post = Book.where("title LIKE ?", "%#{words}")
    end
	end
end
