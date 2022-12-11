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

ods graphics / reset width=8in height=4.5in imagemap;
proc sgplot  data=year_vs_platform;
	series x=year y=Number_of_platforms /markers smoothconnect;
	yaxis integer;
	title height=14pt "The Most Popular Platform";
	yaxis grid integer label="Number of Platforms";
run;
ods graphics / reset;