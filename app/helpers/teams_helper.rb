module TeamsHelper
  def tournament_divisions
    Tournament.all.collect do |t|
      t.divisions.each do |d|
        ["#{t.name} div #{d.name}", d.id]
      end
    end
  end
end
