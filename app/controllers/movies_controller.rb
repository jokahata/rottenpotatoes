class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @movies = Movie.all

	#To get every rating in the movies we have
	#Was not sure if instead I was supposed to go to Movie model and make like a Movies.getRating method
	@all_ratings = Array.new
	@movies.each do |m|
		if !@all_ratings.include?(m.rating)
			@all_ratings.push(m.rating)
		end
	end

	#if a certain rating is selected
	if(params[:ratings] != nil)
		#@movies is an array
		@movies = @movies.select { |m| params[:ratings].has_key?(m.rating)}
	end

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
