[numbers,characters] = xlsread('potential_projects.xlsx','Sheet1');
projects = numbers;
%fund parameters
start_year = 1;
max_year = 10;
proj_no = 1;
proj_per_yr = 3;
capital = 2345000;
%finances
cashflow = zeros(max_year,1);
fund_ROI = zeros(max_year,1);
projects_ROI = zeros(max_year,1);
fund_balance = zeros(max_year,1);
returns = zeros(max_year+1,1);
costs = zeros(max_year+1,1);
DCF = zeros(max_year,1);
r = .06;
%cost includes 2 full time salaries and cost of operating fund
fixed_cost = 170000;

for year  = start_year:max_year
   
   %year 1
   %project investment
   if year == 1
   capital = capital - fixed_cost; 
   cashflow(year) = -fixed_cost;
   costs(year) = fixed_cost;
   
   for proj = 1:proj_per_yr 
      if capital >= projects(proj_no,2)  
        cost = projects(proj_no,2);
        capital = capital - cost;
        cashflow(year) = cashflow(year) - cost;
        costs(year) = costs(year) + cost;
        projects(proj_no,6) = year;
        proj_no = proj_no + 1;
      end
   end 
   
   fund_ROI(year) = -sum(costs(1:year))/capital;
   fund_balance(year) = capital;
   DCF(year) = cashflow(year)/(1+r)^(year-1);
   end  
   
 %after year 1 
 if year > 1 
    returns(year) = sum(projects(1:proj_no-1,3));
    costs(year) = fixed_cost;
    %project investment
    capital = capital - fixed_cost; 
    cashflow(year) = -fixed_cost;
    
%    for proj = 1:proj_per_yr 
%       if (capital >= projects(2,2))  
%         cost = projects(2,2);
%         capital = capital - cost;
%         cashflow(year) = cashflow(year) - cost;
%         costs(year) = costs(year) + cost;
%         projects(proj_no,6) = year;
% %         proj_no = proj_no + 1;
%       end
%    end   
   
       %returns
       capital = capital + returns(year);
       fund_balance(year) = capital;
        
       cashflow(year) = cashflow(year) + returns(year);
       %roi in terms of inital fund 
       %play with lower inital capital
       %build in if returns in x years, don't invest in 5 years, but would
       %hurt NPV
       fund_ROI(year) = sum(cashflow(1:year))/capital;
       projects_ROI(year) = (sum(returns(1:year)) - sum(costs(1:year)))/sum(costs(1:year));
       DCF(year) = cashflow(year)/(1+r)^(year-1);
     
 end
   
   
end


 
project_cost = sum(projects(1:proj_no-1,2));
NPV = sum(DCF); 
total_cost = sum(costs(1:max_year));
total_returns = sum(returns(1:max_year));
end_fund_ROI = (total_returns - total_cost)/capital;


% figure;
% plot((1:max_year),cashflow(1:year));
% title('Yearly Cashflows for Revolving Fund');
% xlabel('Year');
% ylabel('Cashflow ($)');
% 
figure;
plot((1:max_year),fund_ROI(1:year));
title('Yearly ROI for Revolving Fund');
xlabel('Year');
ylabel('ROI');
% % 
% figure;
% plot((1:max_year),fund_balance(1:year));
% title('Year-end Fund Balance for Revolving Fund');
% xlabel('Year');
% ylabel('Balance ($)');
% % 
% figure;
% plot((1:max_year),DCF(1:year));
% title('Discounted Cashflow');
% xlabel('Year');
% ylabel('DCF ($)');
