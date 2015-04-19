class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /users/sign_up
  def new
    super
  end

  def new_basic
    if not user_signed_in?
      redirect_to new_user_registration_path
      flash[:notice] = 'Sign up or Sign in to upgrade'
    else
      @user = current_user
    end
  end

  def new_pro
    @user = User.new 
    if not user_signed_in?
      redirect_to new_user_registration_path
      flash[:notice] = 'Sign up or Sign in to upgrade'
    else
      @user = current_user
    end   
  end

  # POST /resource
  def create
    super
  #current_user.plan_id = "free"
  #current_user.stripe_id = nil
  #current_user.save
  end

  def create_new_basic

  customer = Stripe::Customer.create(
    :email => current_user.email,
    :card  => params[:stripeToken],
    :plan => "basic"
  )

  current_user.plan_id = "basic"
  current_user.stripe_id = customer.id
  current_user.save

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_basic_path
  end

  def create_new_pro
  
  customer = Stripe::Customer.create(
    :email => current_user.email,
    :card  => params[:stripeToken],
    :plan => "pro"
  )

  current_user.plan_id = "pro"
  current_user.stripe_id = customer.id
  current_user.save

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_basic_path  
  end
  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  def downgrade
    if current_user.plan_id == "basic"
      customer = Stripe::Customer.retrieve("#{current_user.stripe_id}")
      customer.subscriptions.retrieve("#{customer.subscriptions.data[0].id}").delete
      customer.delete
      current_user.update(plan_id: nil)
      if current_user.employees.count > 5
        employees_to_delete = current_user.employees.count - 5
        current_user.employees.last(employees_to_delete).each do |e|
          e.delete
        end
      end
      if current_user.reviewers.count > 1
        reviewers_to_delete = current_user.employees.count - 1
        current_user.employees.last(reviewers_to_delete).each do |r|
          r.delete
        end
      end      
      redirect_to employees_path
    elsif current_user.plan_id == "pro"
      customer = Stripe::Customer.retrieve("#{current_user.stripe_id}")
      subscription = customer.subscriptions.retrieve("#{customer.subscriptions.data[0].id}")
      subscription.plan = "basic"
      subscription.save
      current_user.update(plan_id: "basic")
      if current_user.employees.count > 25
        employees_to_delete = current_user.employees.count - 25
        current_user.employees.last(employees_to_delete).each do |e|
          e.delete
        end
      end
      if current_user.reviewers.count > 5
        reviewers_to_delete = current_user.employees.count - 5
        current_user.employees.last(reviewers_to_delete).each do |r|
          r.delete
        end
      end
      redirect_to employees_path
    else
      flash[:notice] = "To downgrade contact your commercial"
      # customer = Stripe::Customer.retrieve("#{current_user.stripe_id}")
      # subscription = customer.subscriptions.retrieve("#{customer.subscriptions.data[0].id}")
      # subscription.plan = "pro"
      # subscription.save
      # current_user.update(plan_id: "pro")
      # if current_user.employees.count > 50
      #   employees_to_delete = current_user.employees.count - 50
      #   current_user.employees.last(employees_to_delete).destroy_all
      # end
      # if current_user.reviewers.count > 10
      #   reviewers_to_delete = current_user.employees.count - 10
      #   current_user.employees.last(reviewers_to_delete).destroy_all
      # end      
      redirect_to employees_path 
    end
  end

  def upgrade
    customer = Stripe::Customer.retrieve("#{current_user.stripe_id}")
    subscription = customer.subscriptions.retrieve("#{customer.subscriptions.data[0].id}")
    subscription.plan = "pro"
    subscription.save
    current_user.update(plan_id: "pro")
    redirect_to employees_path
  end

  # DELETE /resource
  def destroy
    current_user.employees.destroy_all
    current_user.reviewers.destroy_all
    if not current_user.plan_id == nil
      customer = Stripe::Customer.retrieve("#{current_user.stripe_id}")
      customer.subscriptions.retrieve("#{customer.subscriptions.data[0].id}").delete
      customer.delete
    end
    super
  end

  #update average_boder
  def update_average_border
    avrg = params[:average_border].first

    current_user.update(average_border: avrg)

    redirect_to edit_user_registration_path
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :attribute << :plan_id << :stripe_id
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :attribute << :plan_id << :stripe_id
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
