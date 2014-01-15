class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    @movies = Movie.all
    @all_ratings = Movie.get_ratings
    @is_sort_title = false
    @is_sort_release = false

  #If there's a new ordering use it
  if (params[:order] != nil)
    session[:order] = params[:order]
  end

  #Declares and initializes a Hash that holds whether a box is checked or not
  if (session[:ratings] == nil)
    session[:ratings] = Hash.new
    @all_ratings.each do |rating|
      session[:ratings][rating] = true
    end
  end


  #If one or more ratings are selected
  if(params[:ratings] != nil)
    #Goes through the checkbox hash and set false for unchecked boxes
    session[:ratings].each_key do |rating|
      params[:ratings].has_key?(rating) ? (session[:ratings][rating] = true) : (session[:ratings][rating] = false)
    end
  else
    flash.keep
    #redirect_to movies_path, :ratings => session[:ratings]
  end

  #@movies is an array so I use select
  @movies = @movies.select { |m| session[:ratings][m.rating]}

  #Sorting procedures
  if (session[:order] != nil)
    if (session[:order] == 'title')
      @is_sort_title = true
      @movies.sort_by!(&:title) #same as @movies.sort_by{|m| m.title}
    end
    if (session[:order] == 'release')
      @is_sort_release = true
      @movies.sort_by!(&:release_date)
    end
  end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
