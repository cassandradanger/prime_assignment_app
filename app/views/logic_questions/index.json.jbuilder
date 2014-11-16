json.array!(@logic_questions) do |logic_question|
  json.extract! logic_question, :id, :question, :solution, :status
  json.url logic_question_url(logic_question, format: :json)
end
