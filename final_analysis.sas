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

proc sort data=game_sales 
    out=genres;
    by genre;
run;
 
data genre_count;
    set genres;
    by genre;
 
    retain Number_of_genre;
 
    if first.genre then  Number_of_genre = 1;
    else  Number_of_genre =  Number_of_genre + 1;
 
    if last.genre then output;
 
    keep genre Number_of_genre;
run;

ods graphics / reset width=8in height=4.5in imagemap;
proc sgplot  data=genre_count;
	vbar genre /response=Number_of_genre;
	title height=14pt "The Number of genre's per category";
	yaxis grid integer label="Number of genres";
run;

ods graphics / reset;

ods graphics / reset width=8in height=4.5in imagemap;
proc sgplot data=game_sales;
	vbar platform/ response=na_sales stat=mean;
	title height=14pt "The Average Number of sales on platform in North America";
	yaxis grid label="Units sold (in Millions)";
run;
proc sgplot data=game_sales;
	vbar platform/ response=eu_sales stat=mean;
	title height=14pt "The Average Number of sales on platform in Europe";
	yaxis grid label="Units sold (in Millions)";
run;
proc sgplot data=game_sales;
	vbar platform/ response=jp_sales stat=mean;
	title height=14pt "The Average Number of sales on platform in Japan";
	yaxis grid label="Units sold (in Millions)";
run;
proc sgplot data=game_sales;
	vbar platform/ response=other_sales stat=mean;
	title height=14pt "The Average Number of sales on platform in Other Countries";
	yaxis grid label="Units sold (in Millions)";
run;
proc sgplot data=game_sales;
	vbar platform/ response=global_sales stat=mean;
	title height=14pt "The Average Number of sales on platform in Globally";
	yaxis grid integer label="Units sold (in Millions)";
run;

ods graphics / reset;


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

data rank_vs_sales;
    set game_sales;
    where rank < 21;
    keep rank year na_sales eu_sales jp_sales other_sales global_sales;
run;
ods graphics / reset width=8in height=4.5in imagemap;
proc sgplot data=rank_vs_sales;
	vbar rank/ response=other_sales;
	title height=14pt "The Number of sales in Other Countries";
	yaxis grid integer label="Units sold (in Millions)";
run;
proc sgplot data=rank_vs_sales;
	vbar rank/ response=jp_sales;
	title height=14pt "The Number of sales based on rank in Japan";
	yaxis grid integer label="Units sold (in Millions)";
run;
proc sgplot data=rank_vs_sales;
	vbar rank/ response=eu_sales;
	title height=14pt "The Number of sales based on rank in Europe";
	yaxis grid integer label="Units sold (in Millions)";
run;
proc sgplot data=rank_vs_sales;
	vbar rank/ response=na_sales;
	title height=14pt "The Number of sales based on rank in North America";
	yaxis grid integer label="Units sold (in Millions)";
run;
proc sgplot data=rank_vs_sales;
	vbar rank/ response=global_sales;
	title height=14pt "The Number of sales based on rank Globally";
	yaxis grid integer label="Units sold (in Millions)";
run;

ods graphics / reset;

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

ods graphics / reset width=8in height=4.5in imagemap;
proc sgplot  data=year_vs_publisher;
	series x=year y=Number_of_publishers /markers smoothconnect;
	title height=14pt "The Number of publishers over the years";
	yaxis grid integer label="Number of publishers";
run;

ods graphics / reset;

ods graphics / reset width=8in height=4.5in imagemap;
proc chart data=game_sales;
	pie genre/ sumvar=na_sales type=mean;
	title "Average of sales per genre in North America";
	pie genre/ sumvar=eu_sales type=mean;
	title "Average of sales per genre in Europe";
run;
proc chart data=game_sales;
	pie genre/ sumvar=jp_sales type=mean;
	title "Average of sales per genre in Japan";
	pie genre/ sumvar=other_sales type=mean;
	title "Average of sales per genre in Other Countries";
	pie genre/ sumvar=global_sales type=mean;
	title "Average of sales per genre Globally";
run;
ods graphics / reset;