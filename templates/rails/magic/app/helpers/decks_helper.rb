module DecksHelper

	def updatedAt(t)
		t.revs.last.nil? ? t.updated_at : t.revs.last.updated_at
	end

	def makeDeckLink (t)
		link_to t.name, t 
	end

	def compareRevs(rev1, rev2)
	        @FirstCards = rev1.dcrs.map{|x| [x.card_id,x.amount]}
	        @SecondCards = rev2.dcrs.map{|x| [x.card_id, x.amount]}
	        @both = @SecondCards & @FirstCards #union of cards
	        @diff = ((@SecondCards+@FirstCards) - @both) #intersection minus union
	
	        cards = Array.new
	        curCardId = 0 #@diff.sort_by{|x| x[0]}[0]
	        curAmount = 0
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

end
