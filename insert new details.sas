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

quit;