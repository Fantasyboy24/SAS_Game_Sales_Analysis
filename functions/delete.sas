%macro deleting(Rank);
	%put Rank= &Rank;
	
	data game_sales;
    set game_sales;
    if Rank = &Rank then delete;
	run;
	data game_sales;
	set game_sales;
	Rank = _N_;
	run;
	
	proc sort data= game_sales;
	    by Rank;
	run;	
%mend deleting;

%deleting(1);

proc print data=game_sales;
run;