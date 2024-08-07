class QuizzesController < ApplicationController
  def index
    @list_of_quizzes = Quiz.all.order({ :created_at => :desc })


    render({ :template => "index" })
  end
end
