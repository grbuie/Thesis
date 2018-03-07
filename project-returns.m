%copied and pasted data (starting at row 2, column 3 of csv file) into a matrix entitled "projects"

start_year = 1;
max_year = 10;
proj_no = 1;
proj_per_yr = 2;
capital = 5000000;
cashflow = zeros(1,10);
total_returns = 0;

for year  = start_year:max_year
    %cost includes 2 full time salaries and cost of operating fund
   cost = 200000; 
   for proj = 1:proj_per_yr 
      if (capital > 200000) && (capital > projects(proj_no,2))  
        cost = projects(proj_no,2);
        capital = capital - cost;
        proj_no = proj_no + 1;  
      end
   end
    returns = 0;
   if year > 1
        returns = sum(projects(1:proj_no,3));
        capital = capital + returns;
        total_returns = total_returns + returns;
   end
   cashflow(1,year) = returns - cost;
end
 
total_cost = sum(projects(1:proj_no,2));
NPV = pvvar(cashflow,.06); 
ROI = (total_returns - total_cost)/total_cost;

figure
plot((1:10),cashflow(1:year));
xlabel('Year');
ylabel('Cashflow ($)');
