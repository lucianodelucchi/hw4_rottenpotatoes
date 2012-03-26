require 'spec_helper'
 
describe Movie do
  describe 'finding similar movies by director' do
    it 'when the movies have the same director' do
      Movie.delete_all
      m1 = Factory(:movie, :director => 'Director1')
      m2 = Factory(:movie, :director => 'Director1')
      m1.find_similar.count.should == 1  
    end
    
    it 'when one movie has a blank director and the others have the same director' do
      Movie.delete_all
      m1 = Factory(:movie)
      m2 = Factory(:movie, :director => 'Director1')
      m3 = Factory(:movie, :director => 'Director1')
      m1.find_similar.count.should == 0  
    end
    
  end
  
  it 'return all ratings' do
    Movie.all_ratings.should == %w(G PG PG-13 NC-17 R)
  end
end