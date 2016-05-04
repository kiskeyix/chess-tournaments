require 'test_helper'

class LineupsHelperTest < ActionView::TestCase
  before do
    @players = [
      {name:"Shaun Cheng", rating:1644, games:9},
      {name:"Andrew Feldman", rating:1739, games:7},
      {name:"Joel Lim", rating:1822, games:8},
      {name:"Sebastien Lipman", rating:882, games:4},
      {name:"Luis Mondesi", rating:1509, games:3},
      {name:"Ming Liu", rating:1850, games:4},
      {name:"Dan Tilkin", rating:1851, games:1}
    ]
  end
  it "must provide best lineup first" do
     sorted_players = @players.sort_by { |player| [-player[:rating]]}
     best_lineups = optimize_lineup @players
     bl = {
       :lineup=>[
         {:name=>"Dan Tilkin", :rating=>1851, :games=>1},
         {:name=>"Ming Liu", :rating=>1850, :games=>4},
         {:name=>"Andrew Feldman", :rating=>1739, :games=>7},
         {:name=>"Luis Mondesi", :rating=>1509, :games=>3}],
       :rating=>1737
     }
     best_lineups.first.wont_equal bl
     best_lineups = optimize_lineup sorted_players
     best_lineups.first.must_equal bl
  end
end
