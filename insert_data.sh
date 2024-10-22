#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "truncate table games,teams")
cat games.csv | while IFS=','  read year round winner opponent winner_goals opponent_goals
do 
    if [[ $year != year ]]
    then 
      #insert teams
      existing_winner_record=$($PSQL "select count(*) from teams where name = '$winner'")
      echo $existing_winner_record
      if [[ $existing_winner_record -eq 0 ]]
      then
        echo $($PSQL "insert into teams(name) values('$winner')");
      fi
      existing_opponent_record=$($PSQL "select count(*) from teams where name = '$opponent'")
      if [[ $existing_opponent_record -eq 0 ]]
      then
        echo $($PSQL "insert into teams(name) values('$opponent')");
      fi
    fi
done


cat games.csv | while IFS=','  read year round winner opponent winner_goals opponent_goals
do 
    if [[ $year != year ]]
    then 
      # insert games
      winner_id=$($PSQL "select team_id from teams where name = '$winner'")
      opponent_id=$($PSQL "select team_id from teams where name = '$opponent'")
      echo $($PSQL "insert into games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) values('$year','$round','$winner_id','$opponent_id','$winner_goals','$opponent_goals')")
    fi
done