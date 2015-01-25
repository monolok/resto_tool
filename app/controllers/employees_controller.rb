class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @employees = Employee.all
    #respond_with(@employees)

    @list_s = Array.new
    @employees.each do |e|
      @n = 0
      e.scores.each do |s|
        @n = @n +1
        @list_s.push(s.average)
        @kf_sum = @list_s.inject(:+)
        @kf = @kf_sum/@n
      end
    end
  end

  def show
    respond_with(@employee)
  end

  def new
    @employee = current_user.employees.build
    respond_with(@employee)
  end

  def edit
  end

  def create
    @employee = current_user.employees.build(employee_params)
    @employee.save
    respond_with(@employee)
  end

  def update
    @employee.update(employee_params)
    respond_with(@employee)
  end

  def destroy
    @employee.destroy
    respond_with(@employee)
  end

  def score_new
    @employee = Employee.find(params[:employee_id])
    @score = @employee.scores.build
    @mood = [['Very bad', 1], ['Bad', 2], ['Average', 3], ['Good', 4], ['Very good', 5]]
  end

  def score_create
    @employee = Employee.find(params[:employee_id])
    @score = @employee.scores.build(score_params)

    @values = Array.new
    @values.push(@score.qu1, @score.qu2, @score.qu3, @score.qu4, @score.qu5, @score.qu6, @score.qu7, @score.qu8, @score.qu9, @score.qu10, @score.qu11, @score.qu12, @score.qu13, @score.qu14, @score.qu15, @score.qu16, @score.qu17, @score.qu18, @score.qu19, @score.qu20, @score.qu21, @score.qu22, @score.qu23, @score.qu24, @score.qu25, @score.qu26, @score.qu27, @score.qu28, @score.qu29)
    @sum = @values.inject(:+)

    @score.average = ((@sum.to_f/145)*5).round(2)
    if @score.save
      respond_with(@employee)
    else
      flash[:notice] = "Not saved"
    end    
  end


  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :position, :pom)
    end

    def score_params
      params.require(:score).permit(:qu1, :qu2, :qu3, :qu4, :qu5, :qu6, :qu7, :qu8, :qu9, :qu10, :qu11, :qu12, :qu13, :qu14, :qu15, :qu16, :qu17, :qu18, :qu19, :qu20, :qu21, :qu22, :qu23, :qu24, :qu25, :qu26,:qu27, :qu28, :qu29)
    end
end
