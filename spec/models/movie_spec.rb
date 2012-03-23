require 'spec_helper'
 
describe Movie do
  describe 'finding similar movies by director' do
    Movie.delete_all
    m1 = Factory(:movie)
    m2 = Factory(:movie, :title => 'Fake 2')
    Movie.find_similar(m1.id).count.should == 2
  end
  
end