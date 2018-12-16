class UsersController < ApplicationController

  def top
  end

  def show
  	@book = Book.new
  	@user = User.find(params[:id])
  	@books = @user.books.page(params[:page]).reverse_order
  end

  def index
  	@book = Book.new
  	@user = current_user
  	@users = User.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	user.update(user_params)
  	redirect_to user_path(user.id)
  end



  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :user_image)
  end

end
