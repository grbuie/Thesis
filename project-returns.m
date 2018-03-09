%copied and pasted data (starting at row 2, column 3 of csv file) into a matrix entitled "projects"
start_year = 1;
max_year = 10;
proj_no = 1;
proj_per_yr = 2;
capital = 5000000;
cashflow = zeros(max_year,1);
year_ROI = zeros(max_year,1);
fund_balance = zeros(max_year,1);
DCF = zeros(max_year,1);
total_returns = 0;
%cost includes 2 full time salaries and cost of operating fund
fixed_cost = 200000;
year_cost = 0;
r = .06;

for year  = start_year:max_year
   
   %year 1
   %project investment
   if year == 1
   capital = capital - fixed_costs; 
   year_cost = fixed_cost;
   
   for proj = 1:proj_per_yr 
      if capital > projects(proj_no,2)  
        cost = projects(proj_no,2);
        capital = capital - cost;
        proj_no = proj_no + 1;
        year_cost = year_cost + cost;
      end
   end 
   cashflow(year) = - year_cost;
   fund_balance(year) = capital;
   year_ROI(year) = (returns - year_cost)/year_cost;
   DCF(year) = cashflow(year)/(1+r)^(year-1);
   end  
   
 %after year 1 
 if year > 1
     %project investment
    capital = capital - fixed_costs; 
    year_cost = fixed_cost;
   
   for proj = 1:proj_per_yr 
      if (capital > projects(proj_no,2))  
        cost = projects(proj_no,2);
        capital = capital - cost;
        proj_no = proj_no + 1;
        year_cost = year_cost + cost;
      end
   end   
   
       %returns
       returns = sum(projects(1:(proj_no - proj_per_yr),3));
       capital = capital + returns;
       total_returns = total_returns + returns;
        
       cashflow(year) = returns - year_cost;
       year_ROI(year) = (returns - year_cost)/year_cost;
       DCF(year) = cashflow(year)/(1+r)^(year-1);
       fund_balance(year) = capital;
 end
   
   
end


 
total_cost = sum(projects(1:proj_no,2));
NPV = sum(DCF); 
ROI = (total_returns - total_cost)/total_cost;

figure;
plot((1:max_year),cashflow(1:year));
title('Yearly Cashflows for Revolving Fund');
xlabel('Year');
ylabel('Cashflow ($)');

% figure;
% plot((1:max_year),year_ROI(1:year));
% title('Yearly ROI for Revolving Fund');
% xlabel('Year');
% ylabel('ROI');
% 
% figure;
% plot((1:max_year),fund_balance(1:year));
% title('Year-end Fund Balance for Revolving Fund');
% xlabel('Year');
% ylabel('Balance ($)');

figure;
plot((1:max_year),DCF(1:year));
title('Discounted Cashflow');
xlabel('Year');
ylabel('DCF ($)');
