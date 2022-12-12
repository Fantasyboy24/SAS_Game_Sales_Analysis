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

%macro new_entry(Name=, Platform=, Year=, Genre=, Publisher=, NA_Sales=, 
		EU_Sales=, JP_Sales=, Other_Sales=, Global_Sales=);

	data data_entry;
		Name="&Name";
		Platform="&Platform";
		Year=&Year;
		Genre="&Genre";
		Publisher="&Publisher";
		NA_Sales=&NA_Sales;
		EU_Sales=&EU_Sales;
		JP_Sales=&JP_Sales;
		Other_Sales=&Other_Sales;
		Global_Sales=&Global_Sales;
	run;

	data id;
	set game_sales end=last;
	by Rank;
	if last;
	keep Rank;
	Rank = Rank + 1;
	run;
	
	data new;
	merge data_entry id;
	run;
	
%MEND new_entry;

%new_entry(Name=League of legends, Platform=PC, Year=2019, Genre=Strategy, 
	Publisher=i dont know, NA_Sales=0, EU_Sales=0.1, JP_Sales=0.2, 
	Other_Sales=1.1, Global_Sales=5.4);

DATA game_sales;
	SET game_sales new;

proc sort data=game_sales nodupkey;
	by Rank;
run;

PROC PRINT DATA=game_sales;
RUN;

%macro modify_entry(Rank=,Name=,Platform=,Year=,Genre=,Publisher=,NA_Sales=,EU_Sales=,JP_Sales=,Other_Sales=,Global_Sales=);

    data data_entry;
        Rank = &Rank;
        Name = "&Name";
        Platform = "&Platform";
        Year = &Year;
        Genre = "&Genre";
        Publisher = "&Publisher";
        NA_Sales = &NA_Sales;
        EU_Sales = &EU_Sales;
        JP_Sales = &JP_Sales;
        Other_Sales = &Other_Sales;
        Global_Sales = &Global_Sales;
        run;
        
    %MEND modify_entry;
    
    
    
    %modify_entry(Rank=1,Name=League of legends,Platform=PC,Year=2019,Genre=Strategy,Publisher=i dont know,NA_Sales=0,EU_Sales=0.1,JP_Sales=0.2,Other_Sales=1.1,Global_Sales=5.4);
    
    
    data game_sales; 
       merge game_sales data_entry;
    proc sort data = game_sales nodupkey;
    by Rank;
    run;
    proc print data = game_sales; 
    run;  

    %macro deleting(Rank);
        %put Rank= &Rank;
        
        data game_sales;
        set game_sales;
        if Rank = &Rank then delete;
        run;
        data game_sales;
        set game_sales;
        Rank = _N_;
        run;
        
        proc sort data= game_sales;
            by Rank;
        run;	
    %mend deleting;
    
    %deleting(1);
    
    proc print data=game_sales;
    run;

%macro search(filter,query);
    %put query = &query;
    %put filter = &filter;
    
    %if &filter = Rank or &filter = Year %then %do;
                    data result;
                        set game_sales;
                    where Rank = &query or Year = &query;
                run;
                data game_sales;
                modify game_sales;
                where Rank = &query or Year = &query;
                search_count = search_count + 1;
                run;
                proc print data=result;
                run;
        %end;
        %if &filter = Name or &filter = Publisher or &filter = Platform %then %do;
                    data result;
                        set game_sales;
                    where Name = &query or Platform = &query or Publisher = &query;	
                run;
                data game_sales;
                modify game_sales;
                where Name = &query or Platform = &query or Publisher = &query;
                search_count = search_count + 1;
                run;
                proc print data=result;
                run;	
        %end;	
        
%mend search;

%search(Rank,2);