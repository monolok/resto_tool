class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @employees = Employee.all
    respond_with(@employees)
  end

  def show
    # respond_with(@employee)

    @scores = Score.where(employee_id: params[:id])

    @results = Array.new
    @scores.each do |q|
      @results.push(q.qu1)
    end

    @sum = @results.inject(:+)
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
  end

  def score_create
    @employee = Employee.find(params[:employee_id])
    @score = @employee.scores.build(score_params)
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
