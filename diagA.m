function A=diagA(nz,nzb,r,r_B, s,s_B);
Adiag=1+s(2:end)+s_B(2:end)-r(2:end);
Asubs=-s(3:end);
Asuper=-(s_B(1:end-1)-r_B(1:end-1));
%Adiag=1+s(1:end-1)+s_B(1:end-1)-r(1:end-1);
%Asubs=-s(2:end-1);
%Asuper=-([0,s_B(1:end-2)]-[0, r_B(1:end-2)]);

Adiag=Adiag(1:end);
Asubs=[Asubs(1:end);0];
Asuper=Asuper(1:end);

A = spdiags([Asubs,Adiag,Asuper],[-1 0 1],nz-2,nz-2);

end
