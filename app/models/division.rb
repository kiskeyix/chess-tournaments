class Division < ActiveRecord::Base
  belongs_to :tournament
  has_and_belongs_to_many :teams
  accepts_nested_attributes_for :teams #, reject_if: :new_record?, allow_destroy: true

  def name_with_tournament
    "#{tournament.respond_to?(:name) ? tournament.name : "No Tournament Yet"} - #{name}"
  end

  def self.open_tournaments
    #joins(:tournament).where('tournaments.end_date >= ?',Time.now)
    joins(:tournament).where('tournaments.end_date >= ?',Time.now).group(:tournament_id).collect do |div|
      div.tournament
    end
  end

  def self.open_tournaments_without_team(team)
    joins(:tournament => { :divisions => :teams } ).where('tournaments.end_date >= ? AND teams.id != ?',
                                                          Time.now, team.id).group(:tournament_id).collect do |div|
      next if div.tournament.teams.include? team
      div.tournament
    end.compact.uniq
  end
end
