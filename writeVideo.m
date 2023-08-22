
%Run this script to resave <frames> with different parameters

%Make sure frames doesn't have any empty fields

saveName = 'ATP2resave20fps.avi';
savePath = 'A:\Users\Ali Amusat\Desktop\';
frate = 5; %framerate, default 30, smaller = slower


to = append(savePath,saveName);

v = VideoWriter(to);
v.FrameRate = frate;
open(v)
writeVideo(v, frames)
close(v)