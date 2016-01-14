ods html; 
ods listing close; 
ods graphics on; 
Data figure57;
y=0;
y1=0;
e1=0;
do t=1 to 200;
       if t=1 then do;
	    e=normal(0);
        y=1.5*y-0.5*y1+e+0.5*e1;
        output;
        end;
   else do;
       temp=y;
	   e1=e;
	   e=normal(0);
	   y=1.5*y-0.5*y1+e+0.5*e1;
       y1=temp;
       diff1=y-y1;
       output;        
        end;
 end;
drop temp;
run;
Proc gplot data=figure57; 
      symbol i=spline v=circle h=1.5; 
      plot y * t;
      title 'Time plot of ARIMA(1,1,1)';
   run;
proc autoreg data=figure57;
 model y=t/dwprob;
 title;
run;
Proc gplot data=figure57; 
     symbol i=spline v=circle h=1.5; 
      plot diff1 * t;
      title 'Time plot of difference';
   run;
 proc autoreg data=figure57;
  model diff1=t/dwprob;
  title;
  run;
ods graphics off;
ods html close;
ods listing;
