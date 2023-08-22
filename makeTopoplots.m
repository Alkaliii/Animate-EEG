clear;
%This script isn't very good



%paths
DATASETPATH = 'D:\datasets\SavannaExpICA\epoched\MS003_20230227_024820.mat'; %should be processed
SAVENAME = 'ATP2resave20fps.avi'; %should end in .avi
SAVEPATH = 'A:\Users\Ali Amusat\Desktop\'; %where to save the video
frate = 5; %framerate, default 30, smaller = slower

%parameters
DEFINEDzlim = [-2.5 2.33];
preview_before_save = false;


%load dataset
load(DATASETPATH);

%extract target trials and all channels for topoplot
    %ensure cfg.trials is pointed at the right spot in your preprocessed data
    %this may include pointing to a specific column or row depending on how
    %that data is organized
cfg = [];
cfg.trials = find(trial_data.trialinfo(:,1)==2);
trgt_trials_allchan = ft_selectdata(cfg, trial_data);
trgt_trials_allchan = fixsampleinfo(trgt_trials_allchan);

%movieplotER 
    %it can produce an animation faster, useful if you want to preview the data
    %before commiting to this script, it requires a timelockanalysis to be
    %performed.
%cfg = [];
%data = ft_timelockanalysis(cfg,trgt_trials_allchan);
% ft_movieplotER(cfg,data)

%RENDER SCRIPT
figure('Menubar','none','Toolbar','none')
frames = struct('cdata',cell(1,length(trgt_trials_allchan.time{1,1})), 'colormap',cell(1,length(trgt_trials_allchan.time{1,1})));

cfg = [];
cfg.layout = 'GSN-HydroCel-129.sfp';
cfg.layout = ft_prepare_layout(cfg,trgt_trials_allchan);

%aesthethics
cfg.interactive = 'no';
cfg.comment = 'xlim';
cfg.figure = gcf;
cfg.colorbar = 'SouthOutside';
cfg.zlim = DEFINEDzlim;
cfg.marker = 'on';
cfg.colormap = '*PiYG';
cfg.style = 'both'; %fill is pretty cool
cfg.dataname = "anim";

total = length(trgt_trials_allchan.time{1,1});

for i = 1:total
    cfg.xlim = [trgt_trials_allchan.time{1,1}(1,i) trgt_trials_allchan.time{1,1}(1,i)];
    
    %ft_topoplotER(cfg, trgt_trials_allchan);
    cfg = topoplot_common(cfg,trgt_trials_allchan);

    frames(i) = getframe(gcf);
    disp("PROGRESS: "+i+"/"+total)
end

%!xlim is time, I don't know why this value has two dimensions
%!zlim seems to be trial, I don't know if it averaged the trials or did a
%topo for a specific one

%Make sure frames doesn't have any empty fields

if preview_before_save
    movie(frames)
end

to = append(SAVEPATH,SAVENAME);
disp("Saving animation to <"+to+"> please wait...")


v = VideoWriter(to);
open(v)
writeVideo(v, frames)
close(v)