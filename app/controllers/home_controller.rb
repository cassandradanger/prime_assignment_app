class HomeController < ApplicationController
  def index
  	@cohorts = Cohort.current
  end
end
