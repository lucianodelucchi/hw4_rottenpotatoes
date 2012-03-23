require 'spec_helper'

describe MoviesController do
  describe 'finding similar movies by director' do
    
    it 'routes to Find Similar Movies' do
      { :get => similar_movie_path(1) }.should route_to( :controller => "movies", :action => "similar", :id => '1' )
    end
    
    it 'should call the model method that retrieves Similar movies' do
      Movie.should_receive(:find_similar).with("1")
      Movie.should_receive(:find).with("1")
      get :similar, {:id => 1}
    end
    
    it 'should select the Similar movies template for rendering' do
      Movie.stub(:find_similar)
      get :similar, {:id => '1'}
      response.should render_template('similar')
    end
    
    it 'should make the Similar movies results available to that template' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_similar).and_return(fake_results)
      get :similar, {:id => '1'}
      # look for controller method to assign @movies
      assigns(:movies).should == fake_results
    end
    
  end
end