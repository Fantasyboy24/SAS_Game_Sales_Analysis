%macro modify_entry(Rank=,Name=,Platform=,Year=,Genre=,Publisher=,NA_Sales=,EU_Sales=,JP_Sales=,Other_Sales=,Global_Sales=);

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
       
   %MEND modify_entry;
   
   
   
   %modify_entry(Rank=1,Name=League of legends,Platform=PC,Year=2019,Genre=Strategy,Publisher=i dont know,NA_Sales=0,EU_Sales=0.1,JP_Sales=0.2,Other_Sales=1.1,Global_Sales=5.4);
   
   
   data game_sales; 
      merge game_sales data_entry;
   proc sort data = game_sales nodupkey;
   by Rank;
   run;
   proc print data = game_sales; 
   run;  
   quit;