module TournamentsHelper
  def collection_links(c)
    c.collect do |r|
      link_to r.name, r
    end.join(', ')
  end
end
