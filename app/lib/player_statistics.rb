# frozen_string_literal: true

module PlayerStatistics
  module_function

  def challenge_in_match_completed?(player, match, challenge_type)
    player_stats = get_stats_for_the_match(player, match)
    challenge_completed?(player_stats, challenge_type)
  end

  def challenge_in_last_matches_completed?(player, challenge_type, games_count = 3)
    player_stats = get_stats_for_last_games(player, games_count)
    player_stats.each do |stat|
      return true if challenge_completed?(stat, challenge_type)
    end
    false
  end

  def get_stats_leaders_from_team(team, player_stats_type)
    Stat.includes(:player, :game)
        .select { |s| s.player.team_id == team.id }
        .sort_by(&:"#{player_stats_type}")
        .reverse
        .first(5)
        .map do |s|
          [
            "#{player_stats_type.capitalize}: #{s.send(player_stats_type)}",
            "Name: #{s.player.first_name} #{s.player.last_name}",
            "Match ID: #{s.game.match_id}",
            "Match date: #{s.game.game_date}"
          ]
        end
  end

  def get_stats_leaders_from_all_teams(player_stats_type)
    Stat.includes(player: [:team]).includes(:game)
        .sort_by(&:"#{player_stats_type}")
        .reverse
        .first(5)
        .map do |s|
          [
            "Team: #{s.player.team.name}",
            "#{player_stats_type.capitalize}: #{s.send(player_stats_type)}",
            "Name: #{s.player.first_name} #{s.player.last_name}",
            "Match ID: #{s.game.match_id}",
            "Match date: #{s.game.game_date}"
          ]
        end
  end

  private

  def get_stats_for_the_match(player, match)
    current_game = Game.find_by(match_id: match, player_id: player)
    player.stats.find_by(game_id: current_game)
  end

  def get_last_games(player, games_count = 3)
    player.games.order(game_date: :desc).limit(games_count).order(game_date: :asc)
  end

  def get_stats_for_last_games(player, games_count)
    last_games_ids = get_last_games(player, games_count).map(&:id)
    player.stats.select { |stat| last_games_ids.include?(stat.game_id) }
  end

  def challenge_completed?(player_stats, challenge_type)
    case challenge_type
    when :distance
      player_stats.distance >= 10_000
    when :pass_accuracy
      player_stats.pass_accuracy >= 70
    when :hattrick
      player_stats.goals == 3
    when :no_goal
      player_stats.goals.zero?
    else
      raise 'Only theese challenges allowed: distance, pass_accuracy, hattrick, no_goal'
    end
  end
end
