start_year = 1;
max_year = 12;
proj = 1;
max_return = 1;
returns = 0;
max_proj = 2;
capital = 5000000;
cashflow = zeros(1,10);

for year  = start_year:max_year
   cost = 160000; 
   for proj = 1:max_proj
      if capital > 160000  
        cost = cost + projects(max_return,2); 
        capital = capital - cost;
        max_return = max_return +1;
      end
   end
    returns = 0;
   if year > 1
        returns = sum(projects(1:max_return,3));
        capital = capital + returns;
   end
   cashflow(1,year) = returns - cost;
end
 
NPV = pvvar(cashflow,.06); 
