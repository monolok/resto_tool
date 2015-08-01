class EmployeesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if reviewer_signed_in?
      @pom = Array.new
      if current_reviewer.vl == 1
        @pom.push(1)
      end
      if current_reviewer.l == 1
        @pom.push(2)
      end 
      if current_reviewer.m == 1 
        @pom.push(3)
      end
      if current_reviewer.h == 1
        @pom.push(4)
      end
      if current_reviewer.vh == 1
        @pom.push(5)
      end
    end

    if user_signed_in?
      if params[:pom].blank?
        @employees = current_user.employees        
      else
        @employees = current_user.employees.where(pom: params[:pom])
      end

    elsif reviewer_signed_in?
      if params[:pom].present?
        if @pom.present?
          @employees = current_reviewer.user.employees.where(pom: params[:pom]).where.not(pom: @pom)
        else
          @employees = current_reviewer.user.employees.where(pom: params[:pom])          
        end
      else
        if @pom.empty?
          @employees = current_reviewer.user.employees
        else
          @employees = current_reviewer.user.employees.where.not(pom: @pom)
        end
      end
    end

    if user_signed_in?
      if not current_user.reviewers.empty?
        current_user.reviewers.each do |r|
          sign_in(:reviewer, r)
        end
      end
    end
    #respond_with(@employees)
  end

  def show
  @scores = Score.where(employee_id: @employee.id)
    
    @n = 1
    @list_qa = Hash.new
    @list_pb = Hash.new
    while @n != 29
      @qu = @scores.average("qu#{@n}").to_f.round(2)
      if @qu > 3
      @list_qa[@n] = @qu
      else
      @list_pb[@n] = @qu
      end
      @n = @n + 1
    end

    if @scores.last.nil?
      
    else
      @l = 1
      @last_qu = @scores.last
      @last_qu_hash = Hash.new
      while @l != 29
        @last_qu_hash[@l] = @last_qu.attribute_for_inspect("qu#{@l}")
        @l = @l + 1
      end
    end
  end

  def new
    @employee = current_user.employees.build
    @pom_mood = [["1", 1], ['2', 2], ['3', 3], ['4', 4], ['5', 5]]
    respond_with(@employee)
  end

  def edit
    @pom_mood = [['1', 1], ['2', 2], ['3', 3], ['4', 4], ['5', 5]]
  end

  def create
  @employee = current_user.employees.build(employee_params)
    if not @employee.valid?
      flash[:notice] = "Click to upgrade!"
      redirect_to employees_path
    else
      @employee.save
      respond_with(@employee)
    end
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

  def score_destroy
    @score = Score.find(params[:id])
    @show = @score.employee.id
    @score.destroy
    redirect_to employee_path(@show)
  end


  private

    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :position, :pom)
    end

    def score_params
      params.require(:score).permit(:qu1, :qu2, :qu3, :qu4, :qu5, :qu6, :qu7, :qu8, :qu9, :qu10, :qu11, :qu12, :qu13, :qu14, :qu15, :qu16, :qu17, :qu18, :qu19, :qu20, :qu21, :qu22, :qu23, :qu24, :qu25, :qu26,:qu27, :qu28, :qu29, :reviewer_id, :com1, :com2, :com3, :com4, :com5, :com6, :com7, :com8, :com9, :com10, :com11, :com12, :com13, :com14, :com15, :com16, :com17, :com18, :com19, :com20, :com21, :com22, :com23, :com24, :com25, :com26,:com27, :com28, :com29)
    end
end
