json.array!(@profile_questions) do |profile_question|
  json.extract! profile_question, :id, :question, :published, :scoring_guideline_1, :scoring_guideline_2, :scoring_guideline_3, :scoring_guideline_4, :scoring_guideline_5
  json.url profile_question_url(profile_question, format: :json)
end
