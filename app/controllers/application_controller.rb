class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

def destroy_reviewer
	if user_signed_in?
		Reviewer.find(params[:id]).destroy
		flash[:notice] = "Reviewer destroyed"
		redirect_to employees_path
	end
end

end
