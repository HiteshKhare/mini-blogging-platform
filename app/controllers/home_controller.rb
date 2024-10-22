class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]  # Allow access to the index action

  def index
    @message = if user_signed_in?
                 "Welcome, #{current_user.name}!"
               else
                 "Welcome to the Mini Blog! Please sign in or sign up."
               end
  end
end
