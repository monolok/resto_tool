class Employee < ActiveRecord::Base
	belongs_to :user
	has_many :scores

 	validate :thing_count_within_limit, :on => :create

	def thing_count_within_limit
		if self.user.plan_id == nil and self.user.employees(:reload).count >= 5
	 		errors.add(:base, "Exceeded plan limit")
	 		#flash[:notice] = "Exceeded plan limit"
	 		#redirect_to employees_path
	 	elsif self.user.plan_id == "basic" and self.user.employees(:reload).count >= 25
	 		errors.add(:base, "Exceeded plan limit")
	 	elsif self.user.plan_id == "pro" and self.user.employees(:reload).count >= 50
	 		errors.add(:base, "Exceeded plan limit")
	 	else
		end
	end
end
