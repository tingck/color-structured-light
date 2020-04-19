%% load file, crop ROI
pattern = imread('pattern2.bmp');
scanline_p = im2double(pattern(1,1:2:end,:));
channel_p = squeeze(scanline_p);
% indexing: q_c(i) means edge transition from color pattern i-1 to i
q_c = [zeros(3,1), diff(channel_p,1,1)'];

img = imread('sample_data/wall.jpg');
im_height = size(img,1);
im_width = size(img,2);
[J,rect] = imcrop(img);
rect = ceil(rect);
img_crop = imcrop(img,rect);
crop_height = rect(4)+1;
crop_width = rect(3)+1;
% origin of crop image
crop_x = rect(1);
crop_y = rect(2);

%% pattern matching
% parameters
alpha = 0.007;
beta = 0.03;

predict_img = zeros(crop_height,crop_width,3);
predict_idx = zeros(crop_height,125);% position of each pattern edge
for row = 1:crop_height
    row
    scanline = im2double(img_crop(row,:,:));
    channel = squeeze(scanline);
    e_c = [zeros(3,1), diff(channel,1,1)']; % 1D intensity gradient
    % dynamic programming
    dp = zeros(size(e_c,2), size(q_c,2));
    for i = 1:size(e_c,2)
        for j = 1:size(q_c,2)
            if i == 1 || j == 1
                dp(i,j) = 0;
            else
                score_tmp = score(q_c(:,j),e_c(:,i),alpha,beta);
                [dp(i,j), idx] = max([dp(i-1,j-1)+score_tmp,...
                    dp(i-1,j),dp(i,j-1)]);
                
            end
        end
    end
    % construct optimum path
    % every pair(a,b) in match means **edge index** of pattern and img
    match = [];
    p = size(e_c,2);
    q = size(q_c,2);
    while p ~= 1 && q ~= 1
        if dp(p,q)>dp(p-1,q) && dp(p,q)>dp(p,q-1)
            match = [match; [p,q]];
            predict_idx(row,q) = p;
            p = p-1;
            q = q-1;
        elseif dp(p-1,q)>dp(p,q-1)
            p = p-1;
        else
            q = q-1;
        end
    end
    match = flipud(match);
    % constructing visualized pairing result
    prev = 1;
    predict = zeros(1,size(scanline,2),3);
    for i = 1:size(match,1)
        pair = match(i,:);
        predict(:,prev:pair(1),:) = repelem(scanline_p(:,pair(2)-1,:),1,pair(1)-prev+1,1);
        prev = pair(1)+1;
        if i == size(match,1)
            predict(:,prev:end,:) = repelem(scanline_p(:,pair(2),:),1,size(e_c,2)-prev+1,1);
        end
    end
    predict_img(row,:,:) = predict;
end
