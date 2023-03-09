class CommentsController < ApplicationController
  include ActiveModel::Validations
	include SessionsHelper
	before_action :logged_in_user, only: [:create, :destroy, :new]
     validates :text, :presence => true

def create
    @comment = current_user.comments.build(comment_params)
	@rev = Rev.find(comment_params[:rev_id])	
    @deck = Deck.find(@rev.deck_id)
    if !comment_params[:text].blank?
      if @comment.save
        flash[:success] = "Comment created!"
        redirect_to @deck
      end
    else
	flash[:warning]= "Comment can not be empty"
	redirect_to @deck
    end
  end

  def new
	@comment = Comment.new(comment_params[:comment])
  end

private
	def comment_params
		params.require(:comment).permit(:user_id,
						:rev_id, :text)
	end
end
