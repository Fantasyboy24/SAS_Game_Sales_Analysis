%macro new_entry(Rank=,Name=,Platform=,Year=,Genre=,Publisher=,NA_Sales=,EU_Sales=,JP_Sales=,Other_Sales=,Global_Sales=);

%put Rank = &Rank;
%put Name = &Name;
%put Platform = &Platform;
%put Year = &Year;
%put Genre = &Genre;
%put Publisher = &Publisher;
%put NA_Sales = &NA_Sales;
%put EU_Sales = &EU_Sales;
%put JP_Sales = &JP_Sales;
%put Other_Sales = &Other_Sales;
%put Global_Sales = &Global_Sales;



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
	 
%MEND new_entry;



%new_entry(Rank=16601,Name=League of legends,Platform=PC,Year=2019,Genre=Strategy,Publisher=i dont know,NA_Sales=0,EU_Sales=0.1,JP_Sales=0.2,Other_Sales=1.1,Global_Sales=5.4);


DATA test; 
   SET game_sales data_entry;
proc sort data = test nodupkey;
by Rank;
run;
PROC PRINT DATA = test; 
RUN;  
quit;