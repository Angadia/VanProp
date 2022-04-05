class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :find_property, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @properties = Property.order(created_at: :desc)
  end

  def show
    @property = Property.find_by_id params[:id]
    @questions = @property.questions
    @question = Question.new
    @answer = Answer.new
    @application = Application.new
    @appilcation_user = Application.find_by_user_id current_user.id if user_signed_in?
  end

  def new
    redirect_to root_path, { alert: 'Not authorized', status: 303 } and return unless current_user&.administrator

    @property = Property.new
  end

  def create
    unless current_user&.administrator
      redirect_to root_path,
                  { alert: 'Not authorized', status: 303 } and return
    end

    @property = Property.new params.require(:property)
                                   .permit(
                                     :title,
                                     :description,
                                     :location,
                                     :amenities,
                                     :price
                                   )
    @property.user = current_user
    if @property.save  # or @property.persisted?
      redirect_to property_path(@property), { notice: 'Created property', status: 303 }
    else
      render :new, status: 303
    end
  end

  def edit; end

  def update
    @property.update params.require(:property)
                           .permit(
                             :title,
                             :description,
                             :location,
                             :amenities,
                             :price
                           )
    redirect_to @property, status: 303
  end

  def destroy
    redirect_to root_path, { status: 303, notice: 'Property deleted' } and return if @property.destroy
    flash.alert = 'Error, property not deleted'
    render :show, status: 303
  end

  private

  def find_property
    @property = Property.find_by_id params[:id]
  end

  def authorize_user!
    redirect_to root_path, { alert: 'Not authorized', status: 303 } unless can?(:crud, @property)
  end
end
