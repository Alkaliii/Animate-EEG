%.25 - .75, 7500(192) - 15000(384)?
clear;

selectWindow = 215:275; %Place first and last sample 
%average across electrodes
%average across time

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

%FIELDTRIP
% %average non-target trials
% cfg = [];
% nontargetTrials = ft_timelockanalysis(cfg, ntrg_trials);
% 
% %average target trials
% cfg = [];
% targetTrials = ft_timelockanalysis(cfg, trgt_trials);


%need two vars for epoch)

trialBal = min(length(ntrg_trials.trial), length(trgt_trials.trial)); %balance amount of trials
sampleNum = length(export_data.time{1});
%average and cut non-target trials (matlab)
ntrg_trials_epoch = zeros(trialBal,sampleNum);
ntrg_trials_mean = zeros(1,trialBal);

for i = 1:trialBal
   ntrg_trials_epoch(i,:) = mean(ntrg_trials.trial{i},1);
   ntrg_trials_epoch(i, 1) = ntrg_trials_epoch{i}(selectWindow);
   ntrg_trials_mean(i) = mean(ntrg_trials_epoch{i});
end

%average and cut target trials (matlab)
trgt_trials_epoch = zeros(trialBal,sampleNum);
trgt_trials_mean = zeros(1,trialBal);

for i = 1:trialBal
   trgt_trials_epoch(i,:) = mean(trgt_trials.trial{i},1);
   trgt_trials_epoch(i) = trgt_trials_epoch{i}(selectWindow);
   trgt_trials_mean(i) = mean(trgt_trials_epoch{i});
end

[h,p,ci,stats] = ttest2(ntrg_trials_mean, trgt_trials_mean)
bar([mean(ntrg_trials_mean) mean(trgt_trials_mean)])
%hold on
%errorbar(1:2, [mean(ntrg_trials_mean) mean(trgt_trials_mean)], ci, ci)
