class Rev < ActiveRecord::Base
	belongs_to :deck, :class_name => 'Decks'
	belongs_to :user, :class_name => 'User'	
	has_many :comments
	has_many :dcrs
#	has_many :cards, :through => :dcrs
	validates :name, presence: true, length: {maximum: 64}
end
