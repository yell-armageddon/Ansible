class CardsController < ApplicationController
#	attr_accessible :name

	def new
		@card = Card.new
	end

	def index
		@card = Card.all
	end

	def show
		@card = Card.find(params[:id])
	end



end
