[numbers,characters] = xlsread('potential_projects.xlsx','Sheet1');
projects = numbers;
%fund parameters
start_year = 1;
max_year = 5;
proj_no = 1;
proj_per_yr = 3;
next_proj = 1;
capital = 5000000;
%finances
cashflow = zeros(max_year,1);
year_ROI = zeros(max_year,1);
fund_balance = zeros(max_year,1);
returns = zeros(max_year+1,1);
DCF = zeros(max_year,1);
r = .06;
total_returns = 0;
%cost includes 2 full time salaries and cost of operating fund
fixed_cost = 200000;

for year  = start_year:max_year
   
   %year 1
   %project investment
   if year == 1
   capital = capital - fixed_cost; 
   cashflow(year) = -fixed_cost;
   
   for max = 1:proj_per_yr
       if capital > projects(proj_no,2) && (projects(proj_no,6) == 0)   
           cost = projects(proj_no,2);
            capital = capital - cost;
            cashflow(year) = cashflow(year) - cost;
            returns(year+1) = returns(year+1) + projects(proj_no,3);
            projects(proj_no,6) = year;
            proj_no = proj_no + 1;
            next_proj = proj_no;
       end      
   end 
   
   
   fund_balance(year) = capital;

   end  
   
 %after year 1 
 if year > 1
     projects_complete = 0;
     %returns
     for proj = 1:26
         if projects(1:proj,6)> 0
            returns(year) = returns(year) + projects(proj,3);
         end
     end
    %project investment
    capital = capital - fixed_cost; 
    cashflow(year) = -fixed_cost;
    

    for max = 1:3
       if projects_complete < proj_per_yr + 1 
       if (capital > projects(proj_no,2)) && (projects(proj_no,6) == 0) 
          cost = projects(proj_no,2);
          capital = capital - cost;
          cashflow(year) = cashflow(year) - cost;
          projects(proj_no,6) = year;
          proj_no = proj_no + 1;
          projects_complete = projects_complete + 1;
       else
          if (capital > projects(next_proj,2)) && (projects(next_proj,6) == 0)      
          cost = projects(next_proj,2);
          capital = capital - cost;
          cashflow(year) = cashflow(year) - cost;
          projects(next_proj,6) = year;
          projects_complete = projects_complete + 1;
          end
          next_proj = next_proj + 1;
       end
       end
    end
   
       %returns
       capital = capital + returns(year);
       fund_balance(year) = capital;
       total_returns = total_returns + returns(year);
        
       cashflow(year) = cashflow(year) + returns(year);
       year_ROI(year) = cashflow(year)/(cashflow(year)-returns(year));
       DCF(year-1) = cashflow(year)/(1+r)^(year-1);
     
 end
    
end


 
total_cost = sum(projects(1:proj_no-1,2));
NPV = sum(DCF)- cashflow(1); 
ROI = (total_returns - total_cost)/total_cost;

% figure;
% plot((1:max_year),cashflow(1:year));
% title('Yearly Cashflows for Revolving Fund');
% xlabel('Year');
% ylabel('Cashflow ($)');
% 
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
% 
% figure;
% plot((1:max_year),DCF(1:year));
% title('Discounted Cashflow');
% xlabel('Year');
% ylabel('DCF ($)');
