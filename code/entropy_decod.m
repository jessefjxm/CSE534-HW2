function [ entropy_out ] = entropy_decod( input_matrix, n)
// inverse zig-zag
y = fliplr(input_matrix);
s = size(input_matrix,1);
entropy_out(1) = diag(y,s-1);
for i=-(s-1):1:s-2
    d = diag(y,i);
    d = reshape(d, 1, numel(d));
    if ( mod(i,2) == 1)
        d = fliplr(d);
    end
    entropy_out = cat(2, entropy_out, d);
end
entropy_out = reshape(entropy_out, n, n);
end

