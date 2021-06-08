proc import datafile="/home/u57920639/vizsga2/csoro2020.csv"
   out=vizsgaltmegyek
   dbms=dlm
   replace;
   delimiter=';'; 
run;


proc means data=vizsgaltmegyek;
run;



proc import datafile="/home/u57920639/vizsga2/nemCsoro2020.csv"
   out=nemcsoro
   dbms=dlm
   replace;
   delimiter=';';   
run;


proc means data=nemcsoro
run;



proc univariate data=nemcsoro
 histogram / midpoints    = 0 to 100 by 1;
run;




title 'Elmaradottab régiók és az ország többi rész';

axis1 stagger label=none;
axis2 label=(a=1'krumpli');

/* Create space at the bottom of the graph */
footnote h=.01 in ' ';

proc gchart data=sashelp.class;
   vbar name / sumvar=height maxis=axis1 raxis=axis2;
run;
quit;








/* Open the LISTING destination and assign the LISTING style to the graph */
ods listing style=listing;
ods graphics / width=5in height=2.81in;

title 'Mileage by Origin and Type';
proc sgplot data=sashelp.cars(where=(type ne 'Hybrid'));
  vbar origin / response=mpg_city group=type groupdisplay=cluster 
    stat=mean dataskin=gloss;
  xaxis display=(nolabel noticks);
  yaxis grid;
run;




title 'Mileage by Origin and Type';
proc sgpanel data=sashelp.cars(where=(type in ('Sedan' 'Sports'))) noautolegend;
  panelby Type / novarname columns=2 onepanel;
  vbar origin / response=mpg_city stat=mean group=origin;
  rowaxis grid;
  run;
  
  
  
title 'Mileage by Origin and Type';
proc sgpanel data=nemcsoro noautolegend;
  panelby érdemjegy / novarname columns=2 onepanel;
  vbar érdemjegy / response=érdemjegy stat=mean group=érdemjegy;
  rowaxis grid;
  run;




proc import datafile="/home/u57920639/vizsga2/joinedFile.csv"
   out=joined
   dbms=dlm
   replace;
   delimiter=';'; 
run;


/*--Bar Panel--*/

title 'Mileage by Origin and Type';
proc sgpanel data=joined noautolegend;
  panelby 'elmaradott régió-e'n / novarname columns=2 onepanel;
  vbar 'év'n / response='össz pontszám'n stat=mean group='év'n;
  rowaxis grid;
  run;

ods graphics / reset width=6.4in height=4.8in imagemap;

title 'Mileage by Origin and Type';
proc sgpanel data=joined noautolegend;
  panelby 'év'n ;
  vbar 'elmaradott régió-e'n / response='össz pontszám'n stat=mean group='elmaradott régió-e'n;
  rowaxis values=(48 to 60 by 0.5) grid;
  run;


title 'Mileage by Origin and Type';
proc sgpanel data=joined noautolegend;
  panelby 'év'n;
  scatter x=height y=weight;
	xaxis values= (0 to 80 by 5);

  vbar 'elmaradott régió-e'n /bas response='össz pontszám'n stat=mean group='elmaradott régió-e'n;
  
  rowaxis grid;
  run;
  
  
  