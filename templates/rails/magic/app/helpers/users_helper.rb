module UsersHelper

	def formatToInt(string)
		case string
		when nil
			return 10
		when 'Unspecified'		
			return 10
		when 'EDH'
			return 80
		when 'Pauper'
			return 70
		when 'Legacy'
			return 50
		else 
			return 40
		end
	end

end

