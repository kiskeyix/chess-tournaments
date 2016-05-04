module LineupsHelper

  ##
  # optimize a lineup and return the best one for the given
  # +players+ sorted by strongest avergage rating in size of +size+
  # per lineup.
  #
  #   players = [
  #     {name:"Shaun Cheng", rating:1644, games:9},
  #     {name:"Andrew Feldman", rating:1739, games:7},
  #     {name:"Joel Lim", rating:1822, games:8},
  #     {name:"Sebastien Lipman", rating:882, games:4},
  #     {name:"Luis Mondesi", rating:1509, games:3},
  #     {name:"Ming Liu", rating:1850, games:4},
  #     {name:"Dan Tilkin", rating:1851, games:1}
  #   ]
  #   players = players.sort_by { |player| [-player[:rating]]}
  #   p optimize_lineup players
  # 
  # Thanks Joel Lim for submitting this!
  def optimize_lineup(players, size=4, averageRating=1750)
    #puts players
    lineups = players.combination(size).to_a

    lineups = lineups.collect{
      |lineup| {
        lineup: lineup,
        rating: lineup.inject(0) {
          |sum, player| sum + player[:rating]
        }/lineup.size
      }
    }

    lineups = lineups.sort_by { |lineup| [-lineup[:rating]] }

    lineups.select { |lineup| lineup[:rating] <= averageRating }
  end
end
