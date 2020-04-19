loadParams

pattern_padding_len = 27;
pattern_stripe_width = 3;

pts = [];
for match_edge = 2:125
    match_edge
    prev_match_y = 1; % assume monotonicity along y direction
    for y = 1:crop_height
        if predict_idx(y,match_edge) == 0
            continue;
        end
        img_realx = crop_x+predict_idx(y,match_edge)-0.5;
        img_realy = crop_y+y;
        pro_realx = pattern_padding_len + pattern_stripe_width*(match_edge-1)+0.5;
        
        match_len = pro_height-prev_match_y+1;
        [worldPoints,reprojectionErrors] = triangulate(repelem([img_realx,img_realy],match_len,1),...
            [repelem(pro_realx,match_len,1),(prev_match_y:pro_height)'],stereoParams);
        [m,idx] = min(reprojectionErrors);
        pts = [pts; worldPoints(idx,:)];
        % prev_match_y = idx;
    end
end
%%
pcshow(pts)
