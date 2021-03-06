class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def new
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
    @user = @book.user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:create] = "You have creatad book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update] = "You have updated book　successfully."
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end



  private

    def book_params
        params.require(:book).permit(:title, :body, :user_id)
    end

    def correct_user
      user = Book.find(params[:id]).user
      unless current_user.id == user.id
         redirect_to books_path
      end
    end


end