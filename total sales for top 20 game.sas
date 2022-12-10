data rank_vs_sales;
    set game_sales;
    keep rank year na_sales eu_sales jp_sales other_sales global_sales;
run;

proc sgplot data=rank_vs_sales;
	vbar rank/ response=other_sales;
	where rank < 21;
run;
proc sgplot data=rank_vs_sales;
	vbar rank/ response=jp_sales;
	where rank < 21;
run;
proc sgplot data=rank_vs_sales;
	vbar rank/ response=eu_sales;
	where rank < 21;
run;
proc sgplot data=rank_vs_sales;
	vbar rank/ response=na_sales;
	where rank < 21;
run;

proc sgplot data=rank_vs_sales;
	vbar rank/ response=global_sales;
	where rank <21;
run;