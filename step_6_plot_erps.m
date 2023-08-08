clear;

%load dataset
load('PATH_TO_SAVE_PREPROCESSED_DATA'); %<- this needs to be filled correctly each time

%keep parietal lobe channels
keepchannels = {'E52','E92','E60','E64','E95','E85','E51','E97','E64','E62',};

%extract non-target trials and selected channels
cfg = [];
cfg.trials = find(export_data.trialinfo==0);
cfg.channel = keepchannels;
ntrg_trials = ft_selectdata(cfg, export_data);

%extract target trials and selected channels
cfg = [];
cfg.trials = find(export_data.trialinfo==1);
cfg.channel = keepchannels;
trgt_trials = ft_selectdata(cfg, export_data);

%average non-target trials
cfg = [];
nontargetTrials = ft_timelockanalysis(cfg, ntrg_trials);

%average target trials
cfg = [];
targetTrials = ft_timelockanalysis(cfg, trgt_trials);


%show multiplot of target vs non-target
cfg = [];
cfg.layout = 'GSN-HydroCel-129.sfp';
cfg.showlegend = 'yes';
cfg.showoutline = 'yes';
ft_multiplotER(cfg, targetTrials, nontargetTrials);


%show singleplot of target vs non-target
cfg = [];
cfg.showlegend = 'yes';
ft_singleplotER(cfg, targetTrials, nontargetTrials);


%extract target trials and all channels for topoplot
cfg = [];
cfg.trials = find(export_data.trialinfo==0);
ntrg_trials_allchan = ft_selectdata(cfg, export_data);

%extract target trials and all channels for topoplot
cfg = [];
cfg.trials = find(export_data.trialinfo==1);
trgt_trials_allchan = ft_selectdata(cfg, export_data);

%average non-target trials
cfg = [];
nontargetTrialsAllChan = ft_timelockanalysis(cfg, ntrg_trials_allchan);

%average target trials
cfg = [];
targetTrialsAllChan = ft_timelockanalysis(cfg, trgt_trials_allchan);


figure();
cfg = [];
cfg.layout = 'GSN-HydroCel-129.sfp';
cfg.xlim = [0.3 0.5];
cfg.zlim = [-2.5 2.33];
ft_topoplotER(cfg, targetTrialsAllChan, nontargetTrialsAllChan);