class Employee < ActiveRecord::Base
	belongs_to :user
	has_many :scores

 	validate :thing_count_within_limit, :on => :create

	def thing_count_within_limit
	 	if self.user.employees(:reload).count >= 5
	 		errors.add(:base, "Exceeded plan limit")
	 		#flash[:notice] = "Exceeded plan limit"
	 		#redirect_to employees_path
		end
	end
end
