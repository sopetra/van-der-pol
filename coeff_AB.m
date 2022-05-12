function x = coeff_AB ( s ) % vraæa vektor s vrijednosti potrebnih za A-B metodu koraka s (beta_0,...beta_(s-1))
  M = eye(s-1);
  b = ones(s-1,1);
  for i=1:s-1
   M = M + diag( (1/(i+1))*ones(s-1-i,1),-i); 
   b(i) -= 1/(i+1);
  end 
  v = M\b;
  v = [ 1; v ]; % v je duljine s
  
  P = pascal( s, -1 );
  x = zeros( s, 1 );
  
  for i = s:-1:1
    x(i) = (-1)^i*( diag(P, i-s)'*v(s-i+1:s) );
  end
  
  if mod(s,2)==1
    x = -x;
  end
  
end
