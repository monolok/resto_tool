class Score < ActiveRecord::Base
	belongs_to :employee
	belongs_to :reviewer

	scope :get_name, ->(qu = nil){
		case qu
		when 1
			return "Predictable"
		when 2
			return "Ponctuality"
		when 3
			return "Personal"
		when 4
			return "Salary"
		when 5
			return "Rules"
		when 6
			return "Perform"
		when 7
			return "Speed"
		when 8
			return "Supervision"
		when 9
			return "Trustworthy"
		when 10
			return "Improvement"
		when 11
			return "Rush"
		when 12
			return "Focused"
		when 13
			return "Consistency"
		when 14
			return "Interpersonal"
		when 15
			return "Positive"
		when 16
			return "Critics"
		when 17
			return "Confident"
		when 18
			return "Plus"
		when 19
			return "Attitude"
		when 20
			return "Team"
		when 21
			return "Blend in"
		when 22
			return "Hours"
		when 23
			return "Pressure"
		when 24
			return "Legal"
		when 25
			return "Customer"
		when 26
			return "Changes"
		when 27
			return "Situations"
		when 28
			return "Flexibility"
		when 29
			return "Company"
		else
			return "error"
		end
	}

end
