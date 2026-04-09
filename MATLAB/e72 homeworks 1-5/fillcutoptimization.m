
% create a function that optimizes the road 
function cost=fillcutoptimization(h)
L = 100;

x = 1:1:101; %define the spacing of the points along the road
e = 5*sin((3*pi)*x/L) +sin(10*pi*x/L); %given equation for initial elevation
%define the costs of cutting and filling

%phicut =   2*(e-h).^2+ (30*(e-h));
%phifill = 12*(h-e).^2 + (h-e);

 cost = 0; %initial value for the cost

 %determine whether to use cut or fill cost, and add it to the total price
 %of the road
for i = 1:length(h)
    if e(i) > h(i)
         costcut = 2*(e(i)-h(i)).^2+ (30*(e(i)-h(i)));
         cost = cost+costcut;
    else 
       costfill = 12*(h(i)-e(i)).^2 + (h(i)-e(i));
       cost= cost+costfill;

    end
    %create a variable to store the total cost of building the whole road
  totalcost = cost
end

