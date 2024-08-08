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

    redirect_to("/quizzes")
  end
end
