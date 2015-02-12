class Employee < ActiveRecord::Base
	belongs_to :user
	has_many :scores

 #  	validate :thing_count_within_limit, :on => :create

	# def thing_count_within_limit
	# 	if self.user.things(:reload).count >= 5
	# 	  errors.add(:base, "Exceeded thing limit")
	# 	end
	# end
end
