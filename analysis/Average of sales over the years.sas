ods graphics / reset width=8in height=4.5in imagemap;

proc sgplot data=game_sales;
	vline year / response=na_sales stat=mean;
	vline year / response=eu_sales stat=mean;
	vline year / response=jp_sales stat=mean;
	vline year / response=other_sales stat=mean;
	title height=14pt "Average of units sold over the years by country";
	yaxis grid integer label="Units sold(per million)";
	xaxis integer ;
run;


proc sgplot data=game_sales;
	vline year / response=global_sales stat=mean;
	title height=14pt "Average of units sold over the year Globally";
	yaxis grid integer label="Units sold(per million)";
run;

ods graphics / reset;