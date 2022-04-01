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
    if user.administrator
      @pending_applications = Property.pending_applications(updated_at: :asc)
      @pending_questions = Property.pending_questions.order(updated_at: :asc)
      @my_properties = Property.my_properties.order(updated_at: :desc, title: :asc, id: :asc)
    else
      @pending_applications = Application.my_applications.where(status: :pending).order(updated_at: :asc)
      @my_questions = Question.my_questions.order(updated_at: :desc)
      @my_applications = Application.my_applications.order(updated_at: :asc)
    end
  end
end
