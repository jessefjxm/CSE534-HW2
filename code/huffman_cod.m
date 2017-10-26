function [ comp, dict ] = huffman_cod(M)
symbols = unique(M);
m = size(M, 1);
n = size(M, 2);
symbols = reshape(symbols, 1, length(symbols));
if length(symbols) < 2
    comp = 0;
    dict = [0 1];
    return;
end
symbolstmp = [symbols max(symbols)+1];
probs = histcounts(M(:),symbolstmp)./(m*n);

[dict, ~] = huffmandict(symbols, probs);
comp = huffmanenco(M(:),dict);
end