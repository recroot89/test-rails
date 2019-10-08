# README

[![Build Status](https://travis-ci.org/recroot89/test-rails.svg?branch=master)](https://travis-ci.org/recroot89/test-rails)

- [Completed challenge in match check](#challenge_match_check)
- [Completed challenge in last matches check](#challenge_last_matches_check)
- [Show TOP-5 leaders from one team](#team_leaders)
- [Show TOP-5 leaders from all teams](#all_teams_leaders)

##Stack used

- <b>Framework</b>: Rails 6
- <b>Language</b>: Ruby 2.6.4
- <b>Database</b>: Postgresql

## Prepare the app

1. Clone the repo and go to project folder

`cd test-rails`

2. Install and run the app (Docker used)

`make app-install`

3. Next time use `make run` to run the app

4. Reset the database to defaults: `make db-reset`

## Documentation

All statistics methods are define in module `PlayerStatictics`.
Challenge types have to be symbol:

- **:distance** // player covered a distance **`10+km`**
- **:pass_accuracy** // player's passes accuracy is **`>=70%`**
- **:hattrick** // player made a hattrick (3 goals per game)
- **:no_goal** // player has no goals

Pick some objects from the database:

```
team = Team.find_by(name: 'Norwitch')
player = team.players.first
match = Match.find_by(home_team: team)
```

<a id="challenge_match_check"></a>

### Challenge check in concrete match

The method checks whether the player completed the challenge in concrete match. For example use the objects defined above.

Method definition:
`challenge_in_match_completed?(player, match, challenge_type)`

where the first argument is Player object and second is Match object.
You can select select challenge_type from above.

Examples:

`PlayerStatistics.challenge_in_match_completed?(player, match, :distance)`

result:
`true`

`PlayerStatistics.challenge_in_match_completed?(player, match, :pass_accuracy)`

result:
`true`

<a id="challenge_last_matches_check"></a>

### Player challenge check in last matches

This method checks whether the player completed the challenge in last matches at least once. For example use the objects defined above.

Method definition:
`challenge_in_last_matches_completed?(player, challenge_type, games_count = 3)`

where the first argument is Player object and second is challenge_type.
You can define how many games need to be checked (3 by default).

Examples:

`PlayerStatistics.challenge_in_last_matches_completed?(player, :pass_accuracy)`

result:
`false`

`PlayerStatistics.challenge_in_last_matches_completed?(player, :pass_accuracy, 5)`

result:
`true`

<a id="team_leaders"></a>

### Get statistics leaders from one team

This method shows TOP-5 players from one team by the specific player's statistics indicator in one match. For example use the objects defined above.

Player's statistics indicators (have to be string or symbol):

- **:distance** // covered distance
- **:pass_accuracy** // player's passes accuracy
- **:assists** //player's assists
- **:goals** //player's goals
- **:passes** //player's completed passes
- **:fouls** //player's fouls
- **:yellow_cards** //player's yellow cards

Method definition:
`get_stats_leaders_from_team(team, player_stats_type)`

where the first argument is Team object and second is player_stats_type.

Examples:

`PlayerStatistics.get_stats_leaders_from_team(team, :pass_accuracy)`

result (made with `awesome_print`):

```
[
    [0] [
        [0] "Pass_accuracy: 92",
        [1] "Name: Rozanne Bergnaum",
        [2] "Match ID: 501054906",
        [3] "Match date: 2019-09-16"
    ],
    [1] [
        [0] "Pass_accuracy: 92",
        [1] "Name: Rozanne Bergnaum",
        [2] "Match ID: 951035735",
        [3] "Match date: 2019-09-02"
    ],
    [2] [
        [0] "Pass_accuracy: 91",
        [1] "Name: Ellis Heathcote",
        [2] "Match ID: 833541906",
        [3] "Match date: 2019-09-09"
    ],
    [3] [
        [0] "Pass_accuracy: 91",
        [1] "Name: Ellis Heathcote",
        [2] "Match ID: 360983480",
        [3] "Match date: 2019-08-25"
    ],
    [4] [
        [0] "Pass_accuracy: 91",
        [1] "Name: Shaun McGlynn",
        [2] "Match ID: 1042425648",
        [3] "Match date: 2019-08-18"
    ]
]
```

`PlayerStatistics.get_stats_leaders_from_team(team, :distance)`

result (made with `awesome_print`):

```
[
    [0] [
        [0] "Distance: 12000",
        [1] "Name: Rozanne Bergnaum",
        [2] "Match ID: 951035735",
        [3] "Match date: 2019-09-02"
    ],
    [1] [
        [0] "Distance: 11234",
        [1] "Name: Ellis Heathcote",
        [2] "Match ID: 501054906",
        [3] "Match date: 2019-09-16"
    ],
    [2] [
        [0] "Distance: 11102",
        [1] "Name: Ellis Heathcote",
        [2] "Match ID: 360983480",
        [3] "Match date: 2019-08-25"
    ],
    [3] [
        [0] "Distance: 10781",
        [1] "Name: Christene Reynolds",
        [2] "Match ID: 501054906",
        [3] "Match date: 2019-09-16"
    ],
    [4] [
        [0] "Distance: 10452",
        [1] "Name: Shaun McGlynn",
        [2] "Match ID: 833541906",
        [3] "Match date: 2019-09-09"
    ]
]
```

<a id="all_teams_leaders"></a>

### Get statistics leaders from all teams

This method shows TOP-5 players from all teams by the specific player's statistics indicator in one match.

Method definition:
`get_stats_leaders_from_all_teams(player_stats_type)`

where the only argument is player_stats_type.

Examples:

`PlayerStatistics.get_stats_leaders_from_all_teams(:pass_accuracy)`

result (made with `awesome_print`):

```
[
    [0] [
        [0] "Team: Norwitch",
        [1] "Pass_accuracy: 92",
        [2] "Name: Rozanne Bergnaum",
        [3] "Match ID: 501054906",
        [4] "Match date: 2019-09-16"
    ],
    [1] [
        [0] "Team: Norwitch",
        [1] "Pass_accuracy: 92",
        [2] "Name: Rozanne Bergnaum",
        [3] "Match ID: 951035735",
        [4] "Match date: 2019-09-02"
    ],
    [2] [
        [0] "Team: Norwitch",
        [1] "Pass_accuracy: 91",
        [2] "Name: Ellis Heathcote",
        [3] "Match ID: 833541906",
        [4] "Match date: 2019-09-09"
    ],
    [3] [
        [0] "Team: Norwitch",
        [1] "Pass_accuracy: 91",
        [2] "Name: Ellis Heathcote",
        [3] "Match ID: 360983480",
        [4] "Match date: 2019-08-25"
    ],
    [4] [
        [0] "Team: Norwitch",
        [1] "Pass_accuracy: 91",
        [2] "Name: Shaun McGlynn",
        [3] "Match ID: 1042425648",
        [4] "Match date: 2019-08-18"
    ]
]
```

`PlayerStatistics.get_stats_leaders_from_all_teams(:distance)`

result (made with `awesome_print`):

```
[
    [0] [
        [0] "Team: Burnley",
        [1] "Distance: 13112",
        [2] "Name: Winford Abernathy",
        [3] "Match ID: 951035735",
        [4] "Match date: 2019-09-02"
    ],
    [1] [
        [0] "Team: Cardiff",
        [1] "Distance: 12243",
        [2] "Name: Noel Wehner",
        [3] "Match ID: 833541906",
        [4] "Match date: 2019-09-09"
    ],
    [2] [
        [0] "Team: Norwitch",
        [1] "Distance: 12000",
        [2] "Name: Rozanne Bergnaum",
        [3] "Match ID: 951035735",
        [4] "Match date: 2019-09-02"
    ],
    [3] [
        [0] "Team: Burnley",
        [1] "Distance: 11764",
        [2] "Name: Verlene Weimann",
        [3] "Match ID: 951035735",
        [4] "Match date: 2019-09-02"
    ],
    [4] [
        [0] "Team: Watford",
        [1] "Distance: 11643",
        [2] "Name: Luanne Thiel",
        [3] "Match ID: 501054906",
        [4] "Match date: 2019-09-16"
    ]
]
```
