proc chart data=game_sales;
	pie genre/ sumvar=na_sales type=mean;
	pie genre/ sumvar=eu_sales type=mean;
	pie genre/ sumvar=jp_sales type=mean;
	pie genre/ sumvar=other_sales type=mean;
	pie genre/ sumvar=global_sales type=mean;
run;