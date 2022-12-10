proc sort data=game_sales 
    out=sales;
    by publisher;
run;
 
data popular_publisher;
    set sales;
    by publisher;
 
    retain Number_of_publisher;
 
    if first.publisher then  Number_of_publisher = 1;
    else  Number_of_publisher =  Number_of_publisher + 1;
 
    if last.publisher then output;
 
    keep publisher Number_of_publisher;
run;

proc sgplot data=popular_publisher;
	vbar publisher / response=Number_of_publisher;
	where Number_of_publisher > 250;
run;