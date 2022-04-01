class ApplicationsController < ApplicationController
  before_action :authenticate_user!

  def reject
    redirect_to root_path, { alert: 'Not authorized', status: 303 } and return unless can? :update, Application

    application = Application.find params[:id]
    application.update status: :rejected
    redirect_to admin_panel_path, { status: 303, notice: 'Application rejected' }
  end

  def approve
    redirect_to root_path, { alert: 'Not authorized', status: 303 } and return unless can? :update, Application

    application = Application.find params[:id]
    application.update status: :approved
    redirect_to admin_panel_path, { status: 303, notice: 'Application approved' }

  end
end
