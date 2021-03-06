class BookCommentsController < ApplicationController

  before_action :authenticate_user!


  def create
  	book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
  	@comment = BookComment.find(params[:book_id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end



  private

    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end

    def correct_user
      user = BookComment.find(params[:id])
      unless current_user.id == user.id
         redirect_to book_path
      end
    end


end
