class PropertiesController < ApplicationController
  def index
    @properties = Property.order(created_at: :desc)
  end

  def show
    
  end
end
