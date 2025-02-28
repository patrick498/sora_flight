class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def index
  end

  def home
    redirect_to main_path
  end
end
