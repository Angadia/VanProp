class PropertiesController < ApplicationController
  def index
    @properties = Property.order(created_at: :desc)
  end

  def show
    @property = Property.find_by_id params[:id]
    @questions = @property.questions
    @question = Question.new
    @answer = Answer.new
    @application = Application.new
    if user_signed_in?
      @appilcation_user = Application.find_by_user_id current_user.id
    end
  end

  def destroy
    # destroy property
    property = Property.find_by_id params[:id]
    if current_user.id ==  property.user_id
      if property.destroy
        p "property deleted"
        flash[:notice] = "property deleted"
        redirect_to root_path, status: 303
      end 
    end
  end

end
