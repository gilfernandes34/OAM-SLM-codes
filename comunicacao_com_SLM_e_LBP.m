% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  Copyright (C) 2018 HOLOEYE Photonics AG. All rights reserved.
%  Contact: https://holoeye.com/contact/
%  
%  This file is part of HOLOEYE SLM Display SDK.
%  
%  You may use this file under the terms and conditions of the
%  "HOLOEYE SLM Display SDK Standard License v1.0" license agreement.
%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Uses the built-in vortex function to show a vortex on the SLM.

% Import SDK:
add_heds_path;

% Detect SLMs and open a window on the selected SLM:
heds_init_slm;

% Open the SLM preview window (might have an impact on performance):
heds_utils_slm_preview_show;

%construir máscara de fase 
x = -480 : 1 : 480; % a row-vector of points for the x-axis
y = -540 : 1 : 540; % a row-vector of points for the y-axis
[X,Y] = meshgrid(x,y); % create matrices for grids of X and Y
T_0=1;
alpha=1;
l=1;
bigdelta=150;
G=bigdelta;
[M,N]=size(X)
for m = 1:M
for n = 1:N
q = atan2(Y(m,n),X(m,n));
r = sqrt(Y(m,n)^2 + X(m,n)^2);
T(m,n) =mod(q*l,2*pi); % spiral phase mask
%T(m,n) = T_0*exp(alpha*1i*cos(l/2*q-(2*pi*r*cos(q))/G)); % forked diffraction grating
%T(m,n) = 1;
end
end

Treal=real(T);
for b=1:1:1080
    for a=1:1:960
        B(b,a)=Treal(b,a); 
        B(b,1921-a)=Treal(b,a);
    end
end

Breal=real(B);

%neste caso a matriz Breal é a matriz que gera as máscaras de fase nas duas
%metades do SLM para conversão e desconversão do feixe. Para carregar
%outras mascaras de fase a partir deste código basta apenas mudar a matriz e depois
%mudar o nome na função head_show_phasevalues() para condizer com a nova
%matriz.

% Show built-in phase function:
head_show_phasevalues(Breal)

% Please uncomment to close SDK at the end:
% heds_close_slm

imaqhwinfo('winvideo')
%testar com instrhwinfo ou serialportlist
% select the device with the name: 'DO USB Video Capture';

% e.g., 
ndevice = 1;

a = imaqhwinfo('winvideo',ndevice);

% Select the format for the aquisition;
nformat = 8;   % note from my tests the 'a.SupportedFormats' number = 5,9,11 where not working;

% Start up the video.
vid = videoinput('winvideo',ndevice,a.SupportedFormats{nformat});
vid.FramesPerTrigger = 1;
preview(vid);
start(vid);

% Get image and display it.
I = rgb2gray(getdata(vid));      % A = rgb2gray(getsnapshot(vid));
figure, imagesc(I), colormap gray;
delete(vid); stop(vid)

