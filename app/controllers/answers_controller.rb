class AnswersController < ApplicationController
    before_action :find_property, except: :destroy
    def create
        answer = Answer.new params.require(:answer).permit(:body, :question_id)
        answer.user_id = current_user.id
        if answer.save 
            p "answer got saved"
            redirect_to property_path(@property)
        end
    end

    def destroy
        answer = Answer.find_by_id params[:id]  
        if current_user.id == answer.user_id 
            answer.destroy
        end
        redirect_to property_path(params[:format])
    end

    private

    def find_property
        @property = Property.find params[:property_id]
    end
end
