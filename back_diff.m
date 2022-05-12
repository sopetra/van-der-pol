function [x, y] = back_diff (f, a, b, y0, n, s )
 h=(b-a)/n;
 x=linspace(a,b,n+1);
 m = max(size(y0));
 y = zeros(max(size(y0)),n+1);
 y(:,1)=y0;
  
 %RK-4
 for i=1:s-1
    k1 = f(x(i),y(:,i));
    k2 = f(x(i)+h/2,y(:,i)+h/2*k1);
    k3 = f(x(i)+h/2,y(:,i)+h/2*k2);
    k4 = f(x(i+1),y(:,i)+k3*h);
    y(:,i+1) = y(:,i)+(h/6)*(k1+2*k2+2*k3+k4);
 end
 [ a, b ] = coeff_diff_b(s);
 
 for k=1:n-s+1
    g = @(z) z + (y(:,k:k+s-1)*a(1:s) - b*h*f(x(k+s),z) );
    y(:,k+s) = fsolve (g,y(:,k+s-1));
 end
 
 
end
