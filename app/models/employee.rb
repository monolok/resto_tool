class Employee < ActiveRecord::Base
	belongs_to :user
	has_many :scores

 	validate :thing_count_within_limit, :on => :create

	def thing_count_within_limit
		if self.user.plan_id == nil and self.user.employees(:reload).count >= 5
	 		errors.add(:base, "Exceeded plan limit: Click to upgrade !")
	 		#flash[:notice] = "Exceeded plan limit"
	 		#redirect_to employees_path
	 	elsif self.user.plan_id == "basic" and self.user.employees(:reload).count >= 25
	 		errors.add(:base, "Exceeded plan limit: Click to upgrade")
	 	elsif self.user.plan_id == "pro" and self.user.employees(:reload).count >= 50
	 		errors.add(:base, "Exceeded plan limit: Contact us for a custom plan")
	 	else
		end
	end

	scope :get_average, ->(employee_id){
		avrg_arr = Array.new
		target_employee = Employee.find(employee_id)
		target_employee.scores.each do |score|
			avrg_arr.push(score.average)
		end
		if target_employee.scores.empty?
			return 0
		else
			big_avrg = (avrg_arr.inject(:+))/(target_employee.scores.count)
			return big_avrg
		end

	}
end 