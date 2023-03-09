class Deck < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 50}, uniqueness: {case_sensitive: false}
	validates :user_id, presence: true

	
	belongs_to :user, :class_name => 'User'
	has_many :revs
	#	has_many :revs, :class_name => 'Rev'
#	has_many :dcrs, :through => :revs
	#has_many :cards, :through => :dcrs	
end
