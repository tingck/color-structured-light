% Projector-Camera Stereo calibration parameters:

% Intrinsic parameters of camera:
fc_left = [ 2443.948596 2447.023105 ]; % Focal Length
cc_left = [ 1617.674554 1178.677261 ]; % Principal point
alpha_c_left = [ 0.000000 ]; % Skew
kc_left = [ 0.106641 -0.241675 0.002154 -0.002279 0.000000 ]; % Distortion

% Intrinsic parameters of projector:
fc_right = [ 835.471505 1664.507565 ]; % Focal Length
cc_right = [ 245.095026 258.475870 ]; % Principal point
alpha_c_right = [ 0.000000 ]; % Skew
kc_right = [ 0.060402 -4.931531 0.023699 -0.009572 0.000000 ]; % Distortion

% Extrinsic parameters (position of projector wrt camera):
om = [ -0.260802 0.007778 0.007937 ]; % Rotation vector
T = [ -10.236042 -50.339317 217.103252 ]; % Translation vector
