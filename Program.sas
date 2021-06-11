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

proc import datafile="/home/u57920639/vizsga2/joinedFileMagyar.csv"
   out=joinedmagyar
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

title 'Országos átlag (matek) a nemek közt elmaradott régiók nélkül (kék) és az elmaradott régiókkal (piros)';
proc sgpanel data=joined noautolegend;
  panelby 'év'n ;
  vbar 'vizsgázó neme'n / response='össz százalék'n stat=mean group='elmaradott régió-e'n groupdisplay=cluster clusterwidth=0.8;
  rowaxis values=(46 to 58 by 0.5) grid;
  run;

ods graphics / reset width=6.4in height=4.8in imagemap;

title 'Országos átlag (magyar) a nemek közt elmaradott régiók nélkül (kék) és az elmaradott régiókkal (piros)';
proc sgpanel data=joinedmagyar noautolegend;
  panelby 'év'n ;
  vbar 'vizsgázó neme'n / response='össz százalék'n stat=mean group='elmaradott régió-e'n groupdisplay=cluster clusterwidth=0.8;
  rowaxis values=(54 to 72 by 0.5) grid;
  run;

data WORK.szazas WORK.nemszazas;
set joined ;
select ;
 when ( 'össz százalék'n eq 100 ) output WORK.szazas;
 otherwise output WORK.nemszazas;
end ;
run ;

ods graphics / reset width=6.4in height=7.2in imagemap;

proc sgpanel data=WORK.szazas noautolegend;
  panelby 'év'n;
  vbar 'elmaradott régió-e'n / response='össz százalék'n stat=freq group='elmaradott régió-e'n groupdisplay=cluster clusterwidth=0.8;
  rowaxis values=(0 to 408 by 1) grid;
  run;
