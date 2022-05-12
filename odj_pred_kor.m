function [x, y] = odj_pred_kor ( f, a, b, y0, n, m, s )
 h=(b-a)/n;
 x=linspace(a,b,n+1);

 d = max(size(y0));
 y = zeros(d,n+1);
 y(:,1)=y0;
 %RK-4
 for i=1:s-1
    k1 = f(x(i),y(:,i));
    k2 = f(x(i)+h/2,y(:,i)+h/2*k1);
    k3 = f(x(i)+h/2,y(:,i)+h/2*k2);
    k4 = f(x(i+1),y(:,i)+k3*h);
    y(:,i+1) = y(:,i)+(h/6)*(k1+2*k2+2*k3+k4);
 end
 
 b1 = coeff_AB(s); % oboje duljine s
 b2 = coeff_AM(s-1);
 
 F = zeros(d,s);
 for i = 1:s
  F(:,i) = f(x(i),y(:,i)); 
 end
 
 % PREDIKTOR-KOREKTOR
 for k=1:n-s+1
   
  p = y(:,k+s-1) + h*F*b1; % prediktor: A-B

  for j=1:m % korektor: A-M
    p = y(:,k+s-1) + h*( b2(s)*f(x(k+s),p));
    if s>=2  % za s=1 nema ovog èlana
      p +=h*F(:,2:s)*b2(1:s-1);
    end
    
  end
  y(:,k+s) = p;  
  
  if i<n-s+1  
   F(:,1:s-1)=F(:,2:s); F(:,s)=f(x(k+s),y(:,k+s));
  end
  
 end
 

end
