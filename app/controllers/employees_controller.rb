class EmployeesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:pom].blank?
      @employees = current_user.employees
    else
      @pom_clicked = params[:pom]
      @employees = current_user.employees.where(pom: @pom_clicked)
    end
    #respond_with(@employees)
  end

  def show
    @n = 29
    @list_qa = Hash.new
    @list_pb = Hash.new
    while @n != 0
      @qu = Score.where(employee_id: @employee.id).average("qu#{@n}").to_f.round(2)
      if @qu > 2.5
      @list_qa[@n] = @qu
      else
      @list_pb[@n] = @qu
      end
      @n = @n - 1
    end

    if Score.where(employee_id: @employee.id).last.nil?
      
    else
      @l = 29
      @last_qu = Score.where(employee_id: @employee.id).last
      @last_qu_hash = Hash.new
      while @l != 0
        @last_qu_hash[@l] = @last_qu.attribute_for_inspect("qu#{@l}")
        @l = @l -1
      end
    end
  end

  def new
    @employee = current_user.employees.build
    @pom_mood = [['Very low', 1], ['Low', 2], ['Medium', 3], ['High', 4], ['Very high', 5]]
    respond_with(@employee)
  end

  def edit
    @pom_mood = [['Very low', 1], ['Low', 2], ['Medium', 3], ['High', 4], ['Very high', 5]]
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

    if user_signed_in?
      @score.reviewer_id = nil
    else
      @score.reviewer_id = current_reviewer.id
    end

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
      params.require(:score).permit(:qu1, :qu2, :qu3, :qu4, :qu5, :qu6, :qu7, :qu8, :qu9, :qu10, :qu11, :qu12, :qu13, :qu14, :qu15, :qu16, :qu17, :qu18, :qu19, :qu20, :qu21, :qu22, :qu23, :qu24, :qu25, :qu26,:qu27, :qu28, :qu29, :reviewer_id)
    end
end
