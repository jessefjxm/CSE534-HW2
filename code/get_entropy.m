function [entropy_code] = get_entropy (entropy_raw_matrix, n, size)
step = n-1;
tile = entropy_raw_matrix(1:1+step, 1:1+step);
entropy_code = tile(1:find(tile(:),1,'last'));
for i=step+2:step+1:size-step
    for j=step+2:step+1:size-step
        tile = entropy_raw_matrix(i:i+step, j:j+step);
        entropy_code = cat(2, entropy_code, tile(1:find(tile(:),1,'last')));
    end
end