class UpdateCourseData < ActiveRecord::Migration
  def data
    course = Course.new
    course.code = 'PSEA'
    course.name = 'Prime Software Engineering Academy'
    course.description = 'An 18 week program designed to get people with little or no programming experience'\
                         ' employable as entry level developers.'
    course.save

    cohorts = Cohort.all
    cohorts.each do |cohort|
      cohort.course = course
      cohort.save
    end

    apps = AdmissionApplication.all
    apps.each do |app|
      app.course = course
      app.save
    end

    lqs = LogicQuestion.all
    lqs.each do |lq|
      lq.course = course
      lq.save
    end

    pqs = ProfileQuestion.all
    pqs.each do |pq|
      pq.course = course
      pq.save
    end

  end
end
