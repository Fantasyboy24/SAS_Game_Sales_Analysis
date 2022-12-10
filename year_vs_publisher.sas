proc sort data=game_sales 
    out=sales nodupkey;
    by year publisher;
run;
 
data year_vs_publisher;
    set sales;
    by year publisher;
 
    retain Number_of_publishers;
 
    if first.year and first.publisher then  Number_of_publishers = 1;
    else  Number_of_publishers =  Number_of_publishers + 1;
 
    if last.year and last.publisher then output;
 
    keep year Number_of_publishers;
run;


proc sgplot  data=year_vs_publisher;
	series x=year y=Number_of_publishers /markers smoothconnect;
	yaxis integer;
run;