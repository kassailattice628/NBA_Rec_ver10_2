function check_zoom
global sobj

%Zoom
%distance, è„å¿sobj.dist
%ï™äÑ sobj.div_zoom
sobj.zoom_dist_deg = sobj.dist/sobj.div_zoom:(sobj.dist/sobj.div_zoom):sobj.dist;%degree

%angleå≈íË
sobj.zoom_mat1 =[[0,ones(1,sobj.div_zoom)];[0,1:sobj.div_zoom]];

%anle ÇÕ step Ç…Ç∑ÇÈ
sobj.zoom_mat8 = zeros(2,sobj.div_zoom*8+1);
for i = 1:sobj.div_zoom
    sobj.zoom_mat8(1,8*(i-1)+2:8*i+1) = i*ones(1,8);
end
sobj.zoom_mat8(2,:) = [0,repmat(1:8, 1,sobj.div_zoom)];

sobj.zoom_mat16 = zeros(2,sobj.div_zoom*16+1);
for i = 1:sobj.div_zoom
    sobj.zoom_mat16(1,16*(i-1)+2:16*i+1) = i*ones(1,16);
end
sobj.zoom_mat16(2,:) = [0,repmat(1:16, 1,sobj.div_zoom)];


%BW: FineMapping
sobj.BW_mat1 = ones(3,size(sobj.zoom_mat1,2)*2);
sobj.BW_mat1(1:2,:) = repmat(sobj.zoom_mat1,1,2);
sobj.BW_mat1(3,1+size(sobj.BW_mat1,2)/2 : end) = 2;

sobj.BW_mat8 = ones(3,size(sobj.zoom_mat8,2)*2);
sobj.BW_mat8(1:2,:) = repmat(sobj.zoom_mat8,1,2);
sobj.BW_mat8(3,1+size(sobj.BW_mat8,2)/2 : end) = 2;

sobj.BW_mat16 = ones(3,size(sobj.zoom_mat16,2)*2);
sobj.BW_mat16(1:2,:) = repmat(sobj.zoom_mat16,1,2);
sobj.BW_mat16(3,1+size(sobj.BW_mat16,2)/2 : end) = 2;