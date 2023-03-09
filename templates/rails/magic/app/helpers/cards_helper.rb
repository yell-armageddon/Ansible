module CardsHelper

	def OldmakeCardLink(t)
		link_to t.name, 
	"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid="+t.CardSetRelations.order("multiverseid ASC").last.multiverseid.to_s,
	:data =>{:tooltip => 'http://deckbox.org/mtg/'+t.name },
		:class => 'simple'
	end
	def makeCardLink(t)
		link_to t.name, 
	"https://deckbox.org/mtg/"+t.name,
	:data =>{:tooltip => 'http://deckbox.org/mtg/'+t.name },
		:class => 'simple'
	end


	def OldaddCardLink(t)
		link_to t.name, 
	"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid="+t.CardSetRelations.order("multiverseid ASC").last.multiverseid.to_s,
	:data =>{:tooltip => 'http://deckbox.org/mtg/'+t.name },
		:class => 'simple' , :style => "color:#22DE00"
	end
	def OldremoveCardLink(t)
		link_to t.name, 
	"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid="+t.CardSetRelations.order("multiverseid ASC").last.multiverseid.to_s,
	:data =>{:tooltip => 'http://deckbox.org/mtg/'+t.name },
		:class => 'simple', :style =>"color:red"
	end
	def addCardLink(t)
		link_to t.name, 
	"https://deckbox.org/mtg/"+t.name,
	:data =>{:tooltip => 'http://deckbox.org/mtg/'+t.name },
		:class => 'simple' , :style => "color:#22DE00"
	end
	def removeCardLink(t)
		link_to t.name, 
	"https://deckbox.org/mtg/"+t.name,
	:data =>{:tooltip => 'http://deckbox.org/mtg/'+t.name },
		:class => 'simple', :style =>"color:red"
	end
	


	def typeToInt(t)
		# Drop subtype
		sType = t.TYPE.split('—')[0].rstrip
	       case sType
                when 'Creature'
			return 10
		when 'Artifact Creature'
			return 10
		when 'Legendary Creature'
			return 10
		when 'Legendary Artifact Creature'
			return 10
		when 'Enchantment Creature'
		 	return	10
		when 'Legendary Enchantment Creature'
			return 10
		when 'Snow Creature'
			return 10
		when 'Snow Artifact Creature'
			return 10
		when 'Artifact'
			return 20
		when 'Legendary Artifact'
			return 20
		when 'Snow Artifact'
			return 20
		when 'Enchantment'
			return 30
		when 'World Enchantment'
			return 30
		when 'Tribal Enchantment'
			return 30
		when 'Snow Enchantment'
			return 30
		when 'Instant'
			return 40
		when 'Sorcery'
			return 50
		when 'Tribal Sorcery'
			return 50
		when 'Planeswalker'
			return 60
		when 'Land'
			return 80
		when 'Artifact Land'
			return 80
		when 'Basic Snow Land'
			return 80
		when 'Snow Land'
			return 80
		when 'Legendary Land'
			return 80
		when 'Basic Land'
			return 80
		when 'Land Creature'
			return 80
		end
	return 120

	end

	
end
