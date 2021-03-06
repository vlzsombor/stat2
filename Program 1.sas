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

proc univariate data= vizsgaltmegyek;
 histogram / normal
 endpoints = 0 to 100 by 1;
run;

  
proc univariate data= nemcsoro;
 histogram / normal
 endpoints = 0 to 100 by 1;
run;
  


proc import datafile="/home/u57920639/vizsga2/joinedFile.csv"
   out=joined
   dbms=dlm
   replace;
   delimiter=';'; 
run;

ods graphics / reset width=6.4in height=4.8in imagemap;

title 'Országos átlag az elmaradott régiók nélkül (kék) és az elmaradott régiókkal (piros)';
proc sgpanel data=joined noautolegend;
  panelby 'év'n ;
  vbar 'elmaradott régió-e'n / response='össz százalék'n stat=mean group='elmaradott régió-e'n;
  rowaxis values=(46 to 60 by 0.5) grid;
  run;


ods graphics / reset width=6.4in height=4.8in imagemap;

title 'Országos átlag az elmaradott régiók nélkül (kék) és az elmaradott régiókkal (piros)';
proc sgpanel data=joined noautolegend;
  panelby 'év'n ;
  vbar 'vizsgázó neme'n / response='össz százalék'n stat=mean group='elmaradott régió-e'n ;
  rowaxis values=(0 to 120 by 0.5) grid;
  run;

