class QuizzesController < ApplicationController
  def index
    render({ :template => "index" })
  end
end
