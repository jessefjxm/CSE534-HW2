function [sequence]=coding(X,N)
sequence=uint8([]);
vec(1:N*N)=zigzag(X, N);
non0index = find(vec~=0);
non0number = length(non0index);
% Run-length Coding
if non0index(1)==1,
    run=0;
    sequence=cat(1,sequence, run, vec(non0index(1)));
end
for n=2:non0number,
    run=non0index(n)-non0index(n-1)-1;
    sequence=cat(1, sequence, run, vec(non0index(n)));
end
sequence=cat(1, sequence, 255, 255);