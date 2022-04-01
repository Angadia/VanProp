class ApplicationsController < ApplicationController
    def create
        application = Application.new params.require(:application).permit(:property_id, :user_id)
        if application.save
            p "application has been created"
            redirect_to property_path(application.property_id)
        end
    end
end
