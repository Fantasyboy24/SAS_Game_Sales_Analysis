proc sort data=game_sales 
    out=pop_pub;
    by publisher;
run;
 
data popular_publisher;
    set pop_pub;
    by publisher;
 
    retain Number_of_publisher;
 
    if first.publisher then  Number_of_publisher = 1;
    else  Number_of_publisher =  Number_of_publisher + 1;
 
    if last.publisher then output;
 
    keep publisher Number_of_publisher;
run;

ods graphics / reset width=8in height=4.5in imagemap;
proc sgplot data=popular_publisher;
	vbar publisher / response=Number_of_publisher;
	where Number_of_publisher > 250;
	title height=14pt "The Most Popular publishers";
	yaxis grid integer label="Number of Games Published";
run;
ods graphics / reset;