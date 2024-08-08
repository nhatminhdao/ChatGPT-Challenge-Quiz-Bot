class MessagesController < ApplicationController
  def create
    new_message = Message.new
    new_message.content = params.fetch("query_content")
    new_message.role = "user"
    new_message.quiz_id = params.fetch("query_quiz_id") 
    new_message.save

    # create the next assistant response
    prior_messages = Message.all.where({ :quiz_id => new_message.quiz_id })
    
    prior_messages_hashes = []

    prior_messages.each do |message|
      message_hash = { :role => message.role, :content => message.content }
      prior_messages_hashes.push(message_hash)
    end

    # pp prior_messages_hashes

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
    
    api_response = client.chat(
      parameters: {
        model: "gpt-4-turbo",
        messages: prior_messages_hashes
      }
    )

    # pp api_response

    assistant_message = Message.new
    assistant_message.quiz_id = new_message.quiz_id
    assistant_message.role = "assistant"
    assistant_message.content = api_response.fetch("choices").first.fetch("message").fetch("content")
    assistant_message.save

    redirect_to("/quizzes/#{ new_message.quiz_id }")
  end
end
