module RevsHelper

def compareRevs(rev1, rev2)
	@FirstCards = rev1.dcrs.map{|x| [x.card_id,x.amount]}
	@SecondCards = rev2.dcrs.map{|x| [x.card_id, x.amount]}	
	@both = @SecondCards & @FirstCards #union of cards
	@diff = ((@SecondCards+@FirstCards) - @both) #intersection minus union

	cards = Array.new
	curCardId = 0 #@diff.sort_by{|x| x[0]}[0]
	curAmount = 0
	curType = 0
	@diff.sort_by{|x| x[0]}.each do |t|
		if @FirstCards.include?(t)
			t[1]=-t[1]
		end
		if curCardId != t[0]
		       if curCardId !=0	
			 cards.push(Array([curCardId,  curAmount]))
		       end
			curCardId = t[0]
			curAmount =t[1]
		else
			curAmount = curAmount + t[1]
		end
	end
	if curCardId !=0
		cards.push(Array([curCardId,  curAmount]))
	end
	return cards
end

def rev_user_path(rev)
	'/users/'+rev.user_id.to_s
end

def path_to(rev)
 '/decks/'+rev.deck_id.to_s+'/revs/'+rev.rev_nr.to_s
end

def link_to_rev(rev)
  link_to rev.rev_nr.to_s, path_to(rev)
end


	def revNr(rev)
		deck=Deck.where(:id => rev.deck_id ).last
		i = 1
		deck.revs.each do |t|
			if t == rev
				return i
			else 
				i=i+1
			end
		end
	end

	def revToTxtArray(rev)
		text = Array.new
		i = 0
		catid=0
		rev.dcrs.all.each do |t| 
			if t.category_id != catid
				catid = t.category_id
				text[i]="!"+Category.find(catid).name
				i=i+1
			end
			text[i] = t.amount.to_s+" "+t.card.name
			i=i+1	
		end
		return text

	end


	def revToTxt(rev)
		text =  "  "
		rev.dcrs.all.each do |t| 
			text = text+t.amount.to_s+" "+t.card.name+"\r\n"	
		end
		return text
	end

	def countDcrs(rev)
		return		rev.dcrs.count
	end

	def countCards(rev)
		cardCount = 0
		rev.dcrs.all.each do |t|
     			cardCount = cardCount + t.amount
		end
		return cardCount
	end

	def calcCMC(rev)
		calcCMC = 0
                rev.dcrs.all.each do |t|
                        calcCMC = calcCMC + t.amount * t.card.CMC
                end
                return calcCMC

	end


	def check_rev(content,card_db)		
		deck_valid = true
		wrong_cards = []

		content.each do |line|
			line = line.strip
			if !line.empty?
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
				if !card_db.exists?(:name => card)
					deck_valid = false
					flash.now[:danger] = 'Invalid Cards!'
					wrong_cards.push(card)
				end
				end
			end
		end		
	return deck_valid, wrong_cards
	end

	def save_revNot(content, card_db, rev_id)
		content.each do |line|
			line = line.strip
			seperated = line.scan(/\d+[x]?|\D+/)

			sb = 0
			if seperated.length >1
				amount = seperated[0]
				if amount = "S"
					sb = 1
				end
				card = seperated[1].to_s.lstrip		
			else
				amount = 1
				card = seperated[0].to_s.lstrip
			end
			cid = card_db.where(:name => card).last.id


			dcr = Dcr.new(:amount => amount, :card_id => cid,
				      :rev_id  => rev_id, :sb => sb)
			dcr.save
		end	
	end
end
