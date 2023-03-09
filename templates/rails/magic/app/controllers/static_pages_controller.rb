class StaticPagesController < ApplicationController

  def news
	@decks = Rev.order("updated_at").last(8).sort_by{|a| a.deck_id}.reverse	
	  @comments = Comment.order("created_at").last(5).reverse
  end

def Cube
  end
end
