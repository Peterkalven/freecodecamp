#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals)+sum(opponent_goals) as total_goals FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT avg(winner_goals) as average_winner_goals FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT round(avg(winner_goals),2) as average_winner_goals FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT round(avg(winner_goals)+ avg(opponent_goals),16) as average_goals FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT max(winner_goals) as max_goals FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(*)  as more_than_2_goals FROM games where winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo  "$($PSQL "SELECT teams.name FROM teams  join games on games.winner_id = teams.team_id where games.year='2018' and games.round='Final'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT teams.name FROM teams  join games on games.winner_id = teams.team_id where games.year='2014' and games.round='Eighth-Final' union SELECT teams.name FROM teams  join games on games.opponent_id = teams.team_id where games.year='2014' and games.round='Eighth-Final'")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT distinct teams.name FROM teams  join games on games.winner_id = teams.team_id order by teams.name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year || '|' || teams.name FROM teams  join games on games.winner_id = teams.team_id where (games.year='2014' or games.year='2018') and games.round='Final' order by year")"

echo -e "\nList of teams that start with 'Co':"
echo  "$($PSQL "SELECT teams.name FROM teams where name like 'Co%'")"
