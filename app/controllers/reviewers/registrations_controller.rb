class Reviewers::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]
skip_before_action :verify_authenticity_token

  # GET /resource/sign_up
  def new     
     @permit_employees = Hash.new
     @select_employees = current_user.employees.to_a
     n = 0 
     while n < @select_employees.count
     @permit_employees[@select_employees[n].name] = @select_employees[n].id
      n = n+1
     end

     #@permit_employees = [[name,id],[name,id]] 
     super
  end

  # POST /resource
  def create
     super
     current_reviewer.update(user_id: current_user.id)
     sign_out current_reviewer
     if current_user.plan_id == nil and current_user.reviewers.count > 1
      current_user.reviewers.last.destroy
      flash[:alert] = "Reviewer not saved, UPGRADE PLAN"
     elsif current_user.plan_id == "basic" and current_user.reviewers.count > 5
      current_user.reviewers.last.destroy
      flash[:alert] = "Reviewer not saved, UPGRADE PLAN"
     elsif current_user.plan_id == "pro" and current_user.reviewers.count > 10
      current_user.reviewers.last.destroy
      flash[:alert] = "Contact us for a custom plan"      
     else      
      flash[:alert] = "Reviewer created"
     end
     #redirect_to employees_path
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
     super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :attribute << :name << :vl << :l << :m << :h << :vh
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :attribute << :name << :vl << :l << :m << :h << :vh
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    session["user_return_to"] || employees_url
    #super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
