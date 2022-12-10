%macro search(filter,query);
	%put query = &query;
	%put filter = &filter;
	
	%if &filter = Rank or &filter = Year %then %do;
 				data result;
           			set game_sales;
	    			where Rank = &query or Year = &query;
	    			
	    		run;
	    		data game_sales;
	    		set result;
	    		search_count = search_count + 1;
	    		run;
	    		
	    		proc print data=result;
	    		run;
	 %end;
	 %if &filter = Name or &filter = Publisher or &filter = Platform %then %do;
 				data result;
           			set game_sales;
	    			where Name = &query or Platform = &query or Publisher = &query;	
	    		run;
	    		data game_sales;
	    		set result;
	    		search_count = search_count + 1;
	    		run;
	    		
	    		proc print data=result;
	    		run;
	    		
	 %end;	
	 
%mend search;

%search(Rank,2);