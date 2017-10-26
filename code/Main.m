ImgName = 'me';
N = 8;
I = imread(strcat(ImgName,'.gray.subsample.jpg'));
block_size = [N N];

% DCT
func_dct = @(block_struct) dct2(block_struct.data);
I_dct = blockproc(I,block_size,func_dct);

% Quantization
func_quant = @(block_struct) quant(block_struct.data,3);
I_quant = blockproc(uint16(I_dct),block_size,func_quant);

% Entrophy Coding
func_encode = @(block_struct) entropy_cod(block_struct.data, N);
entropy_out = blockproc(I_quant,block_size, func_encode);
entropy_code = get_entropy(entropy_out, N, 1024); 

[comp, dict] = huffman_cod(entropy_code); 
fprintf('Compressed size = %d\n',size(comp,1));
fprintf('Compression ratio = %d\n',(size(I,1)*size(I,2)*255)/size(comp,1));

% Decode
deI = reshape(huffmandeco(comp, dict), size(entropy_code)); 
func_decode = @(block_struct) entropy_decod(block_struct.data, N);
entropy_out = blockproc(deI,block_size, func_decode);

% De-DCT
func_dedct = @(block_struct) idct2(block_struct.data);
deI_dct = blockproc(I_quant,block_size,func_dedct);
imshowpair(I,deI_dct,'montage');
cmap = colormap('gray');
imwrite(deI_dct,cmap,strcat(ImgName,'.gray.decode.jpg'), 'jpeg');

% PSNR
peaksnr = psnr(uint8(deI_dct),I);
fprintf('Peak-SNR = %0.4d\n',peaksnr);