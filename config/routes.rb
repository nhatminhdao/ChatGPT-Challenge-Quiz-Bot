Rails.application.routes.draw do

  get("/", {:controller => "quizzes", :action => "index"})
  get("/quizzes", {:controller => "quizzes", :action => "index"})

  
end
