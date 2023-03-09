class DecksController < ApplicationController
	include SessionsHelper
	include DecksHelper
	before_action :logged_in_user, only: [:create, :destroy, :new]
#	before_action :countCards, only: [:show]

	def countCards
		@deck = Deck.find(params[:id])
		@cardCount = 0
		@deck.dcrs.all.each do |t|
     			@cardCount = @cardCount + t.AMOUNT
		end	
	end

	def new
		@deck = Deck.new
	end
	
	def edit
		@deck = Deck.find(params[:id])
	end

	def update
		@deck = Deck.find(params[:id])
		if @deck.update_attributes(deck_params)
			flash[:success] = "Deck updated!"
			redirect_to @deck
		end	
	end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = "Deck created!"
#      redirect_to root_url
      redirect_to @deck
    else
#      render 'static_pages/home'
      flash[:warning] = "Deck title is to long or empty"
    end
  end

	def oldcreate
		@deck = Deck.new(deck_params)
		if @deck.save
			flash[:succes] = "Welcome to deck!"
			redirect_to @deck
		else
			@title = "Add deck"
			render 'new'
		end
	end


	def index
		@deck = Deck.all
	end

	def show 
		@deck = Deck.find(params[:id])
		@comment = Comment.new
		
		@rev = @deck.revs.order("id").reverse.first
	# Below computes the Compare-Box
		if !@rev.nil?
		@id = @rev.rev_nr
		@deck_id = params[:id]
		if @id.to_i >1
                        @prevRev = Rev.all.where(:rev_nr => @id.to_i-1,
                                         :deck_id => @deck_id).first
                        @cards = compareRevs(@prevRev, @rev)
                end
		end

	end


	private
	def deck_params
		params.require(:deck).permit(:name, :user_id, :format)
	end
end
