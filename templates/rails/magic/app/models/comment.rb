class Comment < ActiveRecord::Base
	belongs_to :rev, :class_name => 'Revs'
	belongs_to :user, :class_name => 'User'
end
