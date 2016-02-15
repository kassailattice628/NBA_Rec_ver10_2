img = imread('FontMap2.tif');
%128*128pixels of image
for i = 1:16%çs
    for j = 1:16%óÒ
        ImgData = img((i-1)*128+1:i*128,(j-1)*128+1:j*128);
        num = (i-1)*16+j;
        if num <= 9
            num_str = ['00',num2str(num)];
        elseif num > 9 && num <= 99
            num_str = ['0', num2str(num)];
        else
            num_str = num2str(num);
        end
        imwrite(ImgData, ['Imgs/Imgae_',num_str,'.tif'],'TIFF');
    end
end
