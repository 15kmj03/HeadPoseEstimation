function [ pitches,yaws,rolls ] = headPoseEstimation( filename )
%HEADPOSEESTIMATION �����p���ω�������s��
%   �ڍא����������ɋL�q



% �����p���p�x�̕ω��𐄒肷��֐�

% �O���[�o�����W�n�ō��J�����̈ʒu�����_�Ƃ���
% �E����W�n

% �t���[�����Ƃɏ����̊�ƂȂ�J������I�����A�؂�ւ���
% ���[�p�x�̕����͎���E�ɐU����������A���ɐU���������
% ���[�p�x����...�E�J�����摜���g�p
% ���[�p�x����...���J�����摜���g�p

% windows��vision.VideoFileReader���g�p����mp4�t�@�C����ǂݍ��ނƂ��A
% matlab.video.read.UseHardwareAcceleration('off')�����s�����ق���
% �����ɂȂ邱�Ƃ�����

%% 1��̂�

frameIdx=0;
prevBbox=[];
pitches=zeros(301,1);
yaws=zeros(301,1);
rolls=zeros(301,1);

% ����ǂݍ���
videoFileReader=vision.VideoFileReader(filename,...
    'VideoOutputDataType', 'uint8');

% �X�e���I�p�����[�^�[�ǂݍ���
load('stereoParamsL1R2.mat')

% ���o��ǂݍ���
% �����Ώۂ̑傫�����̏���A������ݒ�
faceDetector = vision.CascadeObjectDetector('ClassificationModel',...
    'FrontalFaceCART', 'MinSize', [200,200], 'MaxSize', [400,400]);

% 1�t���[���ǂݍ���
[rawStereoImg, EOF] = step(videoFileReader);
frameIdx = frameIdx+1;
display(frameIdx)

% �c�ݖj��
[imgL, imgR] = undistortAndRectifyStereoImage(rawStereoImg,...
    stereoParamsL1R2);

% �O���[�X�P�[���ϊ�
grayL = rgb2gray(imgL);
grayR = rgb2gray(imgR);

% �猟�o
% ���E�̃J�����摜�Ŋ猟�o���s��
[faceBboxL,faceBboxR] = detectFaceBbox(grayL, grayR, faceDetector);

% minDisparity�̐ݒ�
minDisparity = determineMinDisparity(grayL, grayR, faceBboxL,faceBboxR);

% ��J�����̐ݒ�
% �p�x�A�猟�o���ʂɊ�Â��Ċ�J������ݒ�
camera=setCamera(faceBboxL,faceBboxR,0);

% bbox�̐ݒ�
if ~isnan(camera)
    bbox=setBbox(faceBboxL,faceBboxR,camera,size(imgL));
else
    bbox=prevBbox;
    camera=1;
end

% �����v�Z
% bbox�̈���݂̂��v�Z����
% �ŏI�I�Ȗ߂�l�̑傫���͍��J�����摜�̑傫���A�E�J�����摜�̑傫���Ɠ�����
dispMap = disparityBbox(grayL, grayR, bbox, minDisparity, camera);

% 3�������W�v�Z
% L1R2�̃X�e���I�p�����[�^��3�����v�Z
% bbox�̈���݂̂Ő؂�o��
% �ŏI�I�Ȗ߂�l�̑傫����bbox�̑傫���Ɠ�����
xyzPoints = reconstructScene(dispMap, stereoParamsL1R2);
xyzPoints=bbox2ROI(xyzPoints,bbox);

% 3�������W�����J������ɕύX
if camera==2
    xyzPoints=relocate(xyzPoints,stereoParamsL1R2);
end

% ��Ɣw�i�̕���
xyzPoints=refineXyzPoints(xyzPoints);

% ptCloud�̍쐬
% 	���[��0�x�̂Ƃ���ptCloud��face0�Ƃ��ĕۑ�
ptCloud=pointCloud(xyzPoints);
face0 = pcdownsample(ptCloud, 'random', 0.05);
faceMaxYaw = pointCloud([NaN,NaN,NaN]);
faceMinYaw = pointCloud([NaN,NaN,NaN]);
face = face0;

% figure(99);
% pcshow(ptCloud, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
% title('ptCloud');
% drawnow

% �p�x
tform = affine3d;
pitches(frameIdx) = 0;
yaws(frameIdx) = 0;
rolls(frameIdx) = 0;



% prev�̐ݒ�
prevTform=tform;
prevCamera=camera;
prevBbox=bbox;

% ROI�̐ݒ�A�X�e���I�p�����[�^�̒�������킹��
switch camera
    case 1
        [stereoParamsL1R2, ROI] = modifyStereoParams(stereoParamsL1R2, faceBboxL);
    case 2
        [stereoParamsL1R2, ROI] = modifyStereoParams(stereoParamsL1R2, faceBboxR);
end

% bbox�̈ʒu���X�V
prevBbox(2)=prevBbox(2)-ROI(2)-1;

%% ���[�v
while 1
    tic
    
    %% 1�t���[���ǂݍ���
    [rawStereoImg, EOF] = step(videoFileReader);
    frameIdx = frameIdx+1;
    display(frameIdx)
    
    %% ROI�̈�݂̂�؂���
    rawStereoImg = bbox2ROI(rawStereoImg, ROI);
    
    %% �c�ݖj��
    [imgL, imgR] = undistortAndRectifyStereoImage(rawStereoImg,...
        stereoParamsL1R2);
    
    %% �O���[�X�P�[���ϊ�
    grayL = rgb2gray(imgL);
    grayR = rgb2gray(imgR);
    
    %% �猟�o
    % ���E�̃J�����摜�Ŋ猟�o���s��
    [faceBboxL,faceBboxR] = detectFaceBbox(grayL, grayR, faceDetector);
    
    %% ��J�����̐ݒ�
    % �p�x�A�猟�o���ʂɊ�Â��Ċ�J������ݒ�
    camera=setCamera(faceBboxL,faceBboxR,yaws(frameIdx-1));
    
    %% bbox�̐ݒ�
    if ~isnan(camera)
        bbox=setBbox(faceBboxL,faceBboxR,camera,size(imgL));
    else
        disp('prevBbox')
        bbox=prevBbox;
        camera=prevCamera;
    end
    
    %% �����v�Z
    % bbox�̈���݂̂��v�Z����
    % �ŏI�I�Ȗ߂�l�̑傫���͍��J�����摜�̑傫���A�E�J�����摜�̑傫���Ɠ�����
    dispMap = disparityBbox(grayL, grayR, bbox, minDisparity, camera);
    
    %% 3�������W�v�Z
    % L1R2�̃X�e���I�p�����[�^��3�����v�Z
    % bbox�̈���݂̂Ő؂�o��
    % �ŏI�I�Ȗ߂�l�̑傫����bbox�̑傫���Ɠ�����
    xyzPoints = reconstructScene(dispMap, stereoParamsL1R2);
    xyzPoints=bbox2ROI(xyzPoints,bbox);
    
    %% 3�������W�����J������ɕύX
    if camera==2
        xyzPoints=relocate(xyzPoints,stereoParamsL1R2);
    end
    
    %% ��Ɣw�i�̕���
    xyzPoints=refineXyzPoints(xyzPoints);
    
    %% ptCloud�̍쐬
    ptCloud=pointCloud(xyzPoints);
%     figure(99);
%     pcshow(ptCloud, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
%     title('ptCloud');
%     drawnow
    
    %% registration
    mergeSize = 3;
    
    new = pcdownsample(ptCloud, 'random', 0.05);
    tform = pcregrigid(new, face, 'Metric', 'pointToPlane',...
        'Extrapolate', true, 'InitialTransform', prevTform,...
        'MaxIterations', 10, 'InlierRatio', 0.5);
    
    %% registration�̌��ʏ���
    [tform,pitch,yaw,roll]=checkTform(tform,prevTform);
    
    maxYaw=max(yaws);
    minYaw=min(yaws);
    
    pitches(frameIdx) = pitch;
    yaws(frameIdx) = yaw;
    rolls(frameIdx) = roll;
    
    

    
    if yaw > maxYaw
        faceMaxYaw = pctransform(new, tform);
        faceMearge = pcmerge(faceMaxYaw, faceMinYaw, mergeSize);
        face = pcmerge(face0, faceMearge, mergeSize);
    end
    if yaw < minYaw
        faceMinYaw = pctransform(new, tform);
        faceMearge=pcmerge(faceMaxYaw, faceMinYaw, mergeSize);
        face = pcmerge(face0, faceMearge, mergeSize);
    end        
        
    
    %% EOF�̊m�F
    if EOF
        break
    end
    
    %% prev�̐ݒ�
    prevTform=tform;
    prevCamera=camera;
    prevBbox=bbox;
    
    %%
%     toc
end

figure(99);
pcshow(face0, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
title('face0');

figure(98);
pcshow(faceMaxYaw, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
title('faceMaxYaw');

figure(97);
pcshow(faceMinYaw, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
title('faceMinYaw');

figure(96);
pcshow(face, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down')
title('face');

figure(95)
plot(yaws)
grid on
xlabel('�t���[���� [sec]')
ylabel('���[�p�x [deg]')




end

