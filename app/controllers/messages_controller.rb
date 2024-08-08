class MessagesController < ApplicationController
  def create
    new_message = Message.new
    new_message.content = params.fetch("query_content")
    new_message.role = "user"
    new_message.quiz_id = params.fetch("query_quiz_id") 
    new_message.save
    redirect_to("/quizzes/#{ new_message.quiz_id }")
  end
end
