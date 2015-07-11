module TeamsHelper
  def tournament_divisions
    td = []
    Tournament.all.each do |t|
      t.divisions.each do |d|
        td << ["#{t.name} div #{d.name}", d.id]
      end
    end
    td
  end
end
