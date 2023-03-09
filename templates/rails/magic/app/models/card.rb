class Card < ActiveRecord::Base
#	has_many :dcrs#, :class_name => 'Dcrs'
#	has_many :decks, :through => :dcrs
	has_many :CardSetRelations
	has_many :multiverseids, :through => :CardSetRelations
	def maLink 
		result =
	"<a href=\"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid="+self.id.to_s+
	"\" class=\"simple\" data-tooltip=\"http://deckbox.org/mtg/"+ self.name+" \">"+self.name+"</a>"
	end

end
