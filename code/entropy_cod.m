function [ entropy_out ] = entropy_cod( input_matrix, n)
y = fliplr(input_matrix);
s = size(input_matrix,1);
entropy_out(1) = diag(y,s-1);
for i=s-2:-1:-(s-1)
    d = diag(y,i);
    d = reshape(d, 1, numel(d));
    if ( mod(i,2) == 1)
        d = fliplr(d);
    end
    entropy_out = cat(2, entropy_out, d);
end
entropy_out = reshape(entropy_out, n, n);
end

