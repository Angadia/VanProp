class UsersController < ApplicationController
  before_action :authenticate_user!, only: :admin_panel

  def new
    @user = User.new
  end

  def create
    @user = User.new params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, status: 303
    end
  end

  def admin_panel
    if current_user&.administrator
      @my_properties = current_user.properties.order(updated_at: :desc, title: :asc, id: :asc)
      @pending_applications = @my_properties.joins(:applications).where(applications: { status: :pending }).group(:id).order(updated_at: :asc)
      @answered_questions = current_user.answers.group(:question_id).select(:question_id)
      @pending_questions = @my_properties.joins(:questions).where(questions: { display: true }).where.not(questions: { id: @answered_questions }).order(updated_at: :asc)
    else
      @my_applications = current_user.applications.order(updated_at: :asc)
      @pending_applications = @my_applications.where(status: :pending).order(updated_at: :asc)
      @my_questions = current_user.questions.order(updated_at: :desc)
    end
  end
end
