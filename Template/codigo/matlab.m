function [ Rvw ] = vwcovar( v,w,maxlag )
%VWCOVAR [ Rvw ] = vwcovar( v,w,maxlag )
%   Calcula la covarianza Rvw entre dos señales, v y w, hasta un retardo
%   máximo maxlag. Las vectores v y w deben ser de la misma longitud; en
%   caso contrario, se recortará el más largo.

Nv = length(v);
Nw = length(w);
if Nv ~= Nw
warning('Se recortará el vector más largo');
if Nv > Nw
v = v(1:Nw);
N = Nw;
else
w = w(1:Nv);
N = Nv;
end
else
N = Nv; % = Nw;
end

if maxlag > N-1
warning('maxlag debe ser menor a la longitud del vector más corto');
maxlag = N-1;
end

% Usamos, si es posible, 10 veces la cantidad de retardo deseada, para
% utilizar más datos y tener menos error. En caso contrario, todos los
% datos disponibles.
if (maxlag) > N-1
c = maxlag;
elseif (10*maxlag) > N-1
c = N-1;
else
c = 10*maxlag;
end

% Utilizamos funciones optimizadas de Matlab en lugar de hacer los cálculos
% con sumatorias. La normalización insesgada (unbiased) es la habitual y
% pedida en el ejercicio. Consiste en dividir los valores en N-t.
% http://www.mathworks.com/help/signal/ug/correlation-and-covariance.html
xc = xcov(v,w,c,'unbiased'); 
Rvw = xc(c+1:c+1+maxlag);

end

