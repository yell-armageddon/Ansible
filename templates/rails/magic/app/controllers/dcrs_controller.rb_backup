class DcrsController < ApplicationController

	def create
		@dcr = Dcr.new(Dcr_params)	
		@dcr.save
		redirect_to root	
	end

	def new
		@dcr = Dcr.new
	end

	def destroy
#		Dcr.find(params[:id]).destroy
	end

	private
		def Dcr_params
		params.require(:rev).permit(:card_id, :rev_id, :amount)
	end
end
