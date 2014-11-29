class HomeController < ApplicationController
  def index
  	@cohorts = Cohort.current
  	render :layout=>"home"
  end
end
