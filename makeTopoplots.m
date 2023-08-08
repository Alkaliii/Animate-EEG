clear;
%This script is is jank



%Paths
DATASETPATH = 'D:\datasets\SavannaExpICA\epoched\MS003_20230227_024820.mat'
%'PATH_TO_SAVE_PREPROCESSED_DATA'
%TRIALINFOPATH =
%TRIALINFO_COLUMN =
%SAVELOCATIONPATH =

%Parameters
%xLim =
DEFINEDzlim = [-2.5 2.33];
%speed_scale =

%load dataset
load(DATASETPATH); %<- this needs to be filled correctly each time

%extract target trials and all channels for topoplot
cfg = [];
cfg.trials = find(trial_data.trialinfo(:,1)==1);
ntrg_trials_allchan = ft_selectdata(cfg, trial_data);

%extract target trials and all channels for topoplot
cfg = [];
cfg.trials = find(trial_data.trialinfo(:,1)==2);
trgt_trials_allchan = ft_selectdata(cfg, trial_data);

%cfg = [];
%data = ft_timelockanalysis(cfg,trgt_trials_allchan);
% ft_movieplotER(cfg,data)

%BETTER RENDER (from base ft_topoplotER.m)
figure('Menubar','none','Toolbar','none')
frames = struct('cdata',cell(1,length(trgt_trials_allchan.time{1,1})), 'colormap',cell(1,length(trgt_trials_allchan.time{1,1})));

cfg = [];
%fig = open_figure(keepfields(cfg,{'figure','position','visible','renderer'}));
cfg.layout = 'GSN-HydroCel-129.sfp'; %ft_prepare_layout(cfg,trgt_trials_allchan);
cfg.interactive = 'no';
cfg.comment = 'xlim';
cfg.figure = gcf;
cfg.colorbar = 'SouthOutside';
cfg.zlim = DEFINEDzlim;
cfg.marker = 'on';
cfg.colormap = '*PiYG';
cfg.style = 'both'; %fill is pretty cool
cfg.dataname = "anim";

% label = trgt_trials_allchan.label;
% [seldat, sellay] = match_str(label, cfg.layout.label);
% chanX = cfg.layout.pos(sellay,1);
% chanY = cfg.layout.pos(sellay,2);
% [tmp, fig] = ft_plot_topo(chanX,chanY,zeros(numel(chanX),1));
% xdata = get(fig,'xdata');
% ydata = get(fig,'ydata');
% nanmask = get(fig, 'cdata');
% 
% indx = [];
% 
% parameter = 'trial';

for i = 1:length(trgt_trials_allchan.time{1,1})
    cfg.xlim = [trgt_trials_allchan.time{1,1}(1,i) trgt_trials_allchan.time{1,1}(1,i)];
    
    ft_topoplotER(cfg, trgt_trials_allchan);
    %cfg = topoplot_common(cfg,trgt_trials_allchan);
    
    % indy = i;
    % datavector = reshape(mean(parameter(:,indy,indx),3), [size(parameter,1) 1]);
    % datamatrix = griddata(chanX,chanY,datavector,xdata,ydata,'v4');
    % set(fig,'cdata', datamatrix + nanmask)
    

    frames(i) = getframe(gcf);
end

%HALF RENDER (saves some time probs)
% for i = 1:2:length(trgt_trials_allchan.time{1,1})
%     figure();
%     cfg = [];
%     cfg.layout = 'GSN-HydroCel-129.sfp';
%     cfg.xlim = [trgt_trials_allchan.time{1,1}(1,i) trgt_trials_allchan.time{1,1}(1,i)];
%     cfg.zlim = [-2.5 2.33];
%     cfg.colormap = '*PiYG';
%     ft_topoplotER(cfg, trgt_trials_allchan); colorbar
%     frames(i:i+1) = getframe(gcf);
%     close
% end

%FULL RENDER
% for i = 1:length(trgt_trials_allchan.time{1,1})
%     figure();
%     cfg = [];
%     cfg.layout = 'GSN-HydroCel-129.sfp';
%     cfg.xlim = [trgt_trials_allchan.time{1,1}(1,i) trgt_trials_allchan.time{1,1}(1,i)];
%     cfg.zlim = [-2.5 2.33];
%     cfg.colormap = '*PiYG';
%     ft_topoplotER(cfg, trgt_trials_allchan); colorbar
%     frames(i) = getframe(gcf);
%     close
% end

%!xlim is time, I don't know why this value has two dimensions
%!zlim seems to be trial, I don't know if it averaged the trials or did a
%topo for a specific one
%!FT wants cfg.rotate to be specified if possible

%Make sure frames doesn't have any empty fields

movie(frames)
v = VideoWriter('A:\Users\Ali Amusat\Desktop\aTP2.avi'); %change path and give name
open(v)
writeVideo(v, frames)
close(v)