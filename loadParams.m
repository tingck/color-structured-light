% load calibration parameters
run('calibration.m');

cam_width = 3264;
cam_height = 2448;
pro_width = 427;
pro_height = 480;

% intrinsic matrices
intrinsic_cam = [fc_left(1),0,0; 0,fc_left(2),0; cc_left,1]';
intrinsic_proj = [fc_right(1),0,0; 0,fc_right(2),0; cc_right,1]';

cameraParams = cameraParameters('IntrinsicMatrix', intrinsic_cam',...
    'RadialDistortion',kc_left(1:3),'TangentialDistortion', kc_left(4:5));

projectorParams = cameraParameters('IntrinsicMatrix', intrinsic_proj',...
    'RadialDistortion',kc_right(1:3),'TangentialDistortion', kc_right(4:5));

stereoParams = stereoParameters(cameraParams,projectorParams,rotationVectorToMatrix(om),T);
