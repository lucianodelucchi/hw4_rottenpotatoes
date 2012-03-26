require 'spec_helper'

describe MoviesController do
  describe 'finding similar movies by director' do
       
    describe do
      #had to separate this one so the before block doesn't run before this one
      it 'routes to Find Similar Movies'do
        { :get => similar_movie_path(1) }.should route_to( :controller => "movies", :action => "similar", :id => '1' )
      end
      
      it 'should redirect to homepage if no similar movies are found' do
        movie = mock('Movie', :title => 'Title')
        fake_results = []
        Movie.should_receive(:find).with("1").and_return movie
        movie.should_receive(:find_similar).and_return fake_results
        
        get :similar, {:id => '1'}
        
        flash[:notice].should == "'#{movie.title}' has no director info."
        response.should redirect_to movies_path
      end 
    end
    
    describe do
      before(:each) do
        @fake_results = [mock('Movie'), mock('Movie')]
        @movie = mock('Movie')
        
        Movie.should_receive(:find).with("1").and_return @movie
        @movie.should_receive(:find_similar).and_return @fake_results
      end
    
      it 'should call the model method that retrieves Similar movies' do
        get :similar, {:id => 1}
      end
      
      it 'should select the Similar movies template for rendering' do
        get :similar, {:id => '1'}
        response.should render_template('similar')
      end
      
      it 'should make the Similar movies results available to that template' do
        get :similar, {:id => '1'}
        # look for controller method to assign @movies
        assigns(:movie).should == @movie
        assigns(:movies).should == @fake_results
      end

    end
    
  end
  
  describe 'create a movie' do
    it 'routes to Create a movie' do
      { :post => movies_path }.should route_to( :controller => "movies", :action => "create" )
    end
    
    describe do
      before do
        @movie = mock('Movie', :title => 'Title')
        Movie.should_receive(:create!).and_return(@movie)
      end 
      
      it 'should update the flash[:notice]' do
        post :create
        flash[:notice].should == "#{@movie.title} was successfully created."
      end 
      
      it 'should redirect to homepage' do
        post :create
        response.should redirect_to movies_path
      end
      
      it 'should make the new Movie available to the template' do
        post :create
        assigns(:movie).should == @movie
      end   
    end
    
  end
  
end