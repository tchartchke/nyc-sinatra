class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  post '/figures' do
    @figure = Figure.new(params[:figure])
    @figure.titles << Title.create(params[:title]) unless params[:title][:name].empty?
    @figure.landmarks << Landmark.create(params[:landmark]) unless params[:landmark][:name].empty?
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end


  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    updated = Figure.new(params[:figure])

    @figure.name = updated.name
    @figure.titles = updated.titles
    @figure.landmarks = updated.landmarks

    @figure.titles << Title.create(params[:title]) unless params[:title][:name].empty?
    @figure.landmarks << Landmark.create(params[:landmark]) unless params[:landmark][:name].empty?
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end


end


