Rails.application.routes.draw do
  root 'shortner#index'
  get '/:value'=>'shortner#redirect'
  post '/'=>'shortner#generate'
end
