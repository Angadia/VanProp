class SessionsController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.find_by_email params[:email]

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            p session[:user_id]
            p current_user.id
            redirect_to root_path, {notice: "Logged in",status: 303}
        else
            flash.alert = "Wrong email or password!"
            render :new, status: 303 
        end
    end

    def destroy
        session[:user_id] = nil
        flash.notice = "Logged out"
        redirect_to root_path, status: 303
    end
end
