function [K] = array_int(f_int,xc)
%% Inputs
% array function f_int(xc)
%% Outputs
%K array with of the iput legth with the integral at every point
%% Calculation of the integral with trapezium method
K = zeros(1,length(xc));
for n = 2:length(xc)
    K(n) = K(n-1) + (xc(n)-xc(n-1))*(f_int(n)+f_int(n-1))/2;
end
end