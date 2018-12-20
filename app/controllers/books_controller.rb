class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
  	@book = Book.new
  	@books = Book.all
  	@user = current_user
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id

    @books = Book.all
    @user = current_user
  	if @book.save
      flash[:success] = "successfully"
  	  redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def show
  	@book = Book.new
  	@book_show = Book.find(params[:id])
    @user = @book_show.user
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
      flash[:success] = "successfully"
  	  redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

private
  def book_params
  	params.require(:book).permit(:title, :opinion)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
  end

  def correct_user
     book = Book.find(params[:id])
     # belong_toのおかげでnoteオブジェクトからuserオブジェクトへアクセスできる。
    if current_user.id != book.user.id
       redirect_to books_path
    end
  end

end
