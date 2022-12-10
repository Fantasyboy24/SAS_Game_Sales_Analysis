proc sort data=game_sales 
    out=sales nodupkey;
    by year platform ;
run;
 
data year_vs_platform;
    set sales;
    by year platform;
 
    retain Number_of_platforms;
 
    if first.year and first.platform then  Number_of_platforms = 1;
    else  Number_of_platforms =  Number_of_platforms + 1;
 
    if last.year and last.platform then output;
 
    keep year Number_of_platforms;
run;


proc sgplot  data=year_vs_platform;
	series x=year y=Number_of_platforms /markers smoothconnect;
	yaxis integer;
run;