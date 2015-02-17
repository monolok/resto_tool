class Reviewer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	belongs_to :user
	has_many :scores

 #validate :thing_count_within_limit, :on => :create

	# def thing_count_within_limit
	# 	if self.user.things(:reload).count >= 5
	# 	  errors.add(:base, "Exceeded thing limit")
	# 	end
	# end
	
end
