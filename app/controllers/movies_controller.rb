class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @movies = Movie.all

	@all_ratings = Movie.get_ratings

	#Declares and initializes a Hash that holds whether a box is checked or not
	@ratings_checked = Hash.new
	@all_ratings.each do |rating|
		@ratings_checked[rating] = true
	end

	#If one or more ratings are selected
	if(params[:ratings] != nil)
		#Goes through the checkbox hash and set false for unchecked boxes
		@ratings_checked.each_key do |rating|
			(@ratings_checked[rating] = false) if !params[:ratings].has_key?(rating)
		end

		#@movies is an array so I use select
		@movies = @movies.select { |m| params[:ratings].has_key?(m.rating)}
	end

	#Sorting procedures
	if (params[:order] == 'title')
		@movies.sort_by!(&:title) #same as @movies.sort_by{|m| m.title}
	end
	if (params[:order] == 'release')
		@movies.sort_by!(&:release_date)
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
