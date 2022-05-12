function x = coeff_AM ( s ) % vraæa vektor s+1 vrijednost za A-M metodu koraka s (beta_0,...,beta_s)
  M = eye(s);
  b = zeros( s, 1 );
  for i=1:s
   M = M + diag( (1/(i+1))*ones(s-i,1),-i); 
   b(i) -= 1/(i+1);
  end 
  v = M\b;
  v = [ 1; v ];
  
  P = pascal( s+1, -1 );
  x = zeros( s+1, 1 );

  for i = s+1:-1:1
    x(i) = (-1)^(i+1)*( diag(P, i-s-1)'*v(s+1-i+1:s+1) );
  end
  
  if mod(s,2)==1
    x = -x;
  end
    
end
