class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  post '/figures' do
     @figure = Figure.create(name: params["figure"]["name"])
     @figure.title_ids = params["figure"][:title_ids]
     @figure.landmark_ids = params["figure"][:landmark_ids]
     @figure.titles << Title.create(name: params["title"]["name"])
     @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
     @figure.save
  end

  get '/figures/:id' do
    @figure = Figure.all.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.all.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.all.find(params[:id])
    if @figure.name != params["figure"]["name"]
      @figure.name = params["figure"]["name"]
    end

    @figure.title_ids = params["figure"][:title_ids]
    @figure.landmark_ids = params["figure"][:landmark_ids]

    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end

    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end
