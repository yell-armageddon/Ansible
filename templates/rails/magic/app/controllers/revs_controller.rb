class RevsController < ApplicationController
	include SessionsHelper
	include RevsHelper

	before_action :logged_in_user, only: [:create, :destroy, :new]

	def setPhysical
		@deck = Deck.find(params[:deck_id])
		@rev = Rev.all.where(:rev_nr => params[:rev_id],
				     :deck_id => params[:deck_id]).first
		Rev.update(@rev.id, :physical => true)
		redirect_to @deck
	end

	def unsetPhysical
		@deck = Deck.find(params[:deck_id])
		@rev = Rev.all.where(:rev_nr => params[:rev_id],
			     :deck_id => params[:deck_id]).first

		Rev.update(@rev.id, :physical => false)
		redirect_to @deck
	end


	def compare
		@firstRev = Rev.all.where(:deck_id =>params[:firstDeck],
					  :rev_nr => params[:firstRev]).last

		if !params[:secondDeck].nil? & !params[:secondRev].nil?
		@secondRev = Rev.all.where(:deck_id =>params[:secondDeck],
					   :rev_nr=>params[:secondRev]).last
		
		@cards = compareRevs(@firstRev, @secondRev)
		@firstDeck = Deck.all.where(:id=>params[:firstDeck]).last		
		@secondDeck = Deck.all.where(:id=>params[:secondDeck]).last
		else
			@deck = Deck.all
		end
	end


	def export
		@deck = Deck.find(params[:deck_id])
		@rev = Rev.all.where(:rev_nr => params[:rev_id],
				     :deck_id => params[:deck_id]).first
		@con2 = revToTxtArray(@rev)
		@cards = Card.all
		@revMode = "export"
	end
	def edit
		@deck = Deck.find(params[:deck_id])
		@rev = Rev.all.where(:rev_nr => params[:id],
				     :deck_id => params[:deck_id]).first
		@con2 = revToTxtArray(@rev)
		@cards = Card.all
		@revMode = "edit"
		@revNr =  @deck.revs.count+1
	end
	def update
#		@rev = Rev.all.where(:rev_nr => params[:id],
#			     :deck_id => params[:deck_id]).first
		#@deck = Deck.find(params[:deck_id])
		@rev = Rev.find(params[:id])	
	
		@deck = Deck.find(@rev.deck_id)
		
		@revNr =  @deck.revs.count+1
		@cards = Card.all
		@con2 =  rev_params[:content].split("\r\n")
			@revMode = "edit"
		
		#@sb = rev_params[:sideboard]
		#if !@sb.nil?
		#	@sb = @sb.split("\r\n")
		#else @sb = "sideboard leer2"
		#end	
		if check_rev(@con2, @cards)[0]
			if @rev.save
				# delte all dcrs
				@rev.dcrs.each do |f|
					f.destroy
				end	
				# create all dcrs
				save_rev(@con2, @cards, params[:id])
				redirect_to @deck
			else
				render 'static_pages/home'
			end
		end
	end

	def show
		@deck = Deck.find(params[:deck_id])
#		@revNumber = params[:id].to_i
#		@rev = @deck.revs[@revNumber-1]
		@rev = Rev.all.where(:rev_nr => params[:id],
			     :deck_id => params[:deck_id]).first
		if params[:id].to_i >1
			prevRev = Rev.all.where(:rev_nr => params[:id].to_i-1,
					 :deck_id => params[:deck_id]).first
			@cards = compareRevs(prevRev, @rev)
		end
		@comment = Comment.new
	end

	def index
		@deck =	 Deck.find(params[:deck_id])
	end

	def new
		@rev = Rev.new
		@deck = Deck.find(params[:deck_id])
		@revNr =  @deck.revs.count+1
		@revOld = @deck.revs.last
	#	@con2 = revToTxtArray(@revOld)
		@revMode = "new"
	end

	def create
		@revMode = "new"
		@deck = Deck.find(rev_params[:deck_id])
		@revNr =  @deck.revs.count+1	
		
		@nextRev =  @deck.revs.count+1
		@con2 = rev_params[:content].split("\r\n")
		@cards = Card.all
		@rev = current_user.revs.build(rev_params.except(:content))


		@sb = rev_params[:sideboard]
		if !@sb.nil?
			@sb = @sb.split("\r\n")
		else @sb = "sideboard leer"	
end	

		if check_rev(@con2, @cards)[0]
			if @rev.save
				save_rev(@con2, @cards, @rev.id )
				flash[:success] = "Revision created!"
				redirect_to @deck
			else
				flash[:warning] = "Revision title is empty or to long (must be less than 65 chars)"
		#		render 'static_pages/home'
			end
		end
	end

	private

	def rev_params
		params.require(:rev).permit(:name, :deck_id, :user_id, :content,
		:rev_nr, :physical , :sideboard )
	end


	def save_rev(content, card_db, rev_id)
		category = 0;
		content.each do |line|
			if !line.empty?
				line = line.strip
				seperated = line.scan(/\d+[x]?|\D+/)
				if seperated.length >1
					amount = seperated[0]
					card = seperated[1].to_s.lstrip		
				else
					amount = 1
					card = seperated[0].to_s.lstrip
				end
			
if card.downcase=="tainted aether"
        card="Tainted Æther"
end	
					
				if card[0] != "!"
				cid = card_db.where(:name => card).last.id
				@dcr = Dcr.new(:amount => amount, :card_id => cid,:rev_id  => rev_id, :category_id => category)
				@dcr.save
				else
					catName = card[1..-1]
					cat = Category.where(:name => catName).last
					if !cat.nil?
						category = cat.id
					else
						cat = Category.new(:name => catName)
						cat.save
						category = cat.id
					end
				end
			end	
		end
	end

	def Dcr_params
		params.require(:rev).permit(:card_id, :rev_id, :amount)
	end
end
