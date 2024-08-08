class QuizzesController < ApplicationController
  def index
    @list_of_quizzes = Quiz.all.order({ :created_at => :desc })


    render({ :template => "index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_records = Quiz.all.where({ :id => the_id })
    @the_quiz = matching_records.first


    render({ :template => "show" })
  end

  def create
    new_quiz = Quiz.new
    new_quiz.topic = params.fetch("query_topic")
    new_quiz.save

    # create the system mesage

    system_message = Message.new
    system_message.quiz_id = new_quiz.id
    system_message.role = "system"
    system_message.content = "You are a #{new_quiz.topic} tutor. Ask the user five questions to assess their #{new_quiz.topic} proficiency. Start with an easy question. After each answer, increase or decrease the difficulty of the next question based on how well the user answered.

    In the end, provide a score between 0 and 10."
    system_message.save

    # create the first user message

    user_message = Message.new
    user_message.quiz_id = new_quiz.id
    user_message.role = "user"
    user_message.content = "Can you assess my #{new_quiz.topic} proficiency?"
    user_message.save

    # create the first assistant response
    prior_messages = [
      { role: "system", content: system_message.content},
      { role: "user", content: user_message.content}
    ]

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
    
    api_response = client.chat(
      parameters: {
        model: "gpt-4-turbo",
        messages: prior_messages
      }
    )

    # pp api_response

    assistant_message = Message.new
    assistant_message.quiz_id = new_quiz.id
    assistant_message.role = "assistant"
    assistant_message.content = api_response.fetch("choices").first.fetch("message").fetch("content")
    assistant_message.save

    redirect_to("/quizzes/#{new_quiz.id}")
  end
end
