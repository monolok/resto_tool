class Score < ActiveRecord::Base
	belongs_to :employee
	belongs_to :reviewer
end
