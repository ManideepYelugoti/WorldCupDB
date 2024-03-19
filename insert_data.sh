#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  #skip first row i.e winner from csv 
  if [[ $WINNER != 'winner' ]]
     then 
      #get winner_id for WINNER 
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      # if not then INSERT into table
      if [[ -z $WINNER_ID ]]
        then 
            INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER') ")
            echo "$INSERT_WINNER_RESULT"
      fi  
  fi 
  
  #skip opponent text from csv 
  if [[ $OPPONENT != 'opponent' ]]
    then
     # get opponent id if exist 
     OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
     #if not exist insert into table
     if [[ -z $OPPONENT_ID ]]
       then
       OPPONENT_INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
       echo "$OPPONENT_INSERT_ID"
       fi
      
  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
if [[ $WINNER != 'winner' ]]
  then
   WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
   OPPOENENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
   echo "$WINNER_ID $WINNER - $OPPOENENT_ID $OPPONENT"
   INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPOENENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)") 
   if [[ $INSERT_GAMES_RESULT = 'INSERT 0 1' ]]
     then echo "inserted into games Table of : $WINNER_ID - $OPPONENT_ID"
   fi  
  
  fi
   

done
