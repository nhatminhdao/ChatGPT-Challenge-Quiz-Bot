Rails.application.routes.draw do

  get("/", {:controller => "quizzes", :action => "index"})
  get("/quizzes", {:controller => "quizzes", :action => "index"})
  get("/quizzes/:path_id", {:controller => "quizzes", :action => "show"})
  post("/insert_quiz", {:controller => "quizzes", :action => "create"})
  post("/insert_message", {:controller => "messages", :action => "create"})
  
  
end
