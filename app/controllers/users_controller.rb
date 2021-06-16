class UsersController < ApplicationController
	def show
		@book = Book.new
		@users = User.all
		@user = User.find(params[:id])
		@books = @user.books
	end
	def edit
		@user = User.find(params[:id])
	end
	def index
		@book = Book.new
		@users = User.all
	end

	def create
		@book = Book.new(book_params)
		if @book.save
        redirect_to users_path, notice:'Welcome! You have signed up successfully.'
	    else
	      render :users
        end
    end
    def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user.id), notice:'You have updated user successfully.'
	    else
	      render :edit
        end
    end
    def destroy
    	session[:keep_signed_out] = true
    	redirect_to "/", notice:'Signed out successfully.'
    end

		def following
			@book = Book.new
			@user = User.find(params[:id])
			@users = @user.followings
		end

		def follower
			@book = Book.new
			@user = User.find(params[:id])
			@users = @user.followers
		end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
	def user_params
	    params.require(:user).permit(:name, :introduction, :profile_image)
	end
end