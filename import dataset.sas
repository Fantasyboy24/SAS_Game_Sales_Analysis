/*Importing the csv into sas*/

%web_drop_table(WORK.GAME_SALES);


FILENAME REFFILE '/home/u62791161/Game_sales/game-sales-clean.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.GAME_SALES;
	GETNAMES=YES;
	GUESSINGROWS=16600;
RUN;

PROC CONTENTS DATA=WORK.GAME_SALES; RUN;

/*initializing search count column*/
data game_sales;
set game_sales;
	search_count = 0;
run;


%web_open_table(WORK.GAME_SALES);