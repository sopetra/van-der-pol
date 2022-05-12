function [x,y] = odj_rk23v (f,y0,a,b,tol)
x(1) = a;
y(:,1) = y0;
c2 = 1/4; c3 = 27/40; c4 = 1; 
a41 = w1 = 214/891; a42 = w2 = 1/33; a43 = w3 = 650/891;
v1 = 533/2106; v2 = 0; v3 = 800/1053; v4 = -1/78;
a21 = 1/4; a31 = -189/800; a32 = 729/800; 
h = b-a;
i=1;
k1=f(x(1),y(:,1));
while x(i)<b
 if x(i)+h > b 
  h = b-x(i); x(i+1) = b;
 else
  x(i+1) = x(i)+h;
 end
 k2 = f(x(i)+c2*h,y(:,i)+h*a21*k1);
 k3 = f(x(i)+c3*h,y(:,i)+h*(a31*k1+a32*k2)); 
 k4 = f(x(i)+c4*h,y(:,i)+h*(a41*k1+a42*k2+a43*k3));
 y(:,i+1) = y(:,i)+h*(w1*k1+w2*k2+w3*k3);
 p = y(:,i)+h*(v1*k1+v2*k2+v3*k3+v4*k4);
 
 k = max(abs(y(:,i+1)-p));
 if k > 0
  h=0.9*h*(tol/k)^(1/3);
 end 
 if abs(y(:,i+1)-p)<=tol
  i=i+1; 
  k1=k4;
 else
  k1=f(x(i),y(:,i)); 
 end 
end 

end
