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
	title height=14pt "The Number of genre per category";
	yaxis grid integer label="Number of genres";
run;

ods graphics / reset;