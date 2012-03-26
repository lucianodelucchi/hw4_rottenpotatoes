require 'spec_helper'
 
describe MoviesHelper do
  it 'handles odd numbers correctly' do
    helper.oddness(1).should == "odd"  
  end
  
  it 'handles even numbers correctly' do
    helper.oddness(2).should == "even"  
  end
  
end