class QuestionsController < ApplicationController

    def create
        @question = Question.new params.require(:question).permit(:body, :property_id, :user_id)
        if @question.save
            p "question has been saved"
        end
        redirect_to property_path(@question.property_id), status: 303
    end

    def destroy
        question = Question.find_by_id params[:id]
        property = Property.find_by_id params[:property_id]
        if current_user.id == question.user_id || current_user.id == property.user_id
            question.destroy
            redirect_to property_path(property.id), status: 303
        end
    end

    def update 
        question = Question.find_by_id params[:id]
        property = Property.find_by_id params[:property_id]
        if current_user.id == question.user_id || current_user.id == property.user_id 
            if question.display
                question.update display: false
                redirect_to property_path(property.id), status: 303
            else
                question.update display: true
                redirect_to property_path(property.id), status: 303
            end
        end
    end

end
