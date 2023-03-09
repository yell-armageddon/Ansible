class Dcr < ActiveRecord::Base
#	belongs_to :rev, :class_name => 'Revs'
	belongs_to :card#, :class_name => 'Cards' #, :foreign_key => "name"
#	has_one :card ,, :class_name => 'Cards'
#has_one :name, :through => :cards
	#
#	has_one :card, :class_name => 'Cards'
#	has_one :name, through: :card
#	has_many :cards
end
