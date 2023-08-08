function [trl,event] = trialfun_p300(cfg)
    hdr        = ft_read_header(cfg.headerfile);
    event      = ft_read_event(cfg.headerfile);
    
    EVsample   = [event.sample]';
    EVvalue    = {event.value}';
    
    trialStart = find(contains(EVvalue, 'G'));
    for w = 1:length(trialStart)
      if strcmp('NTRG', EVvalue{trialStart(w)}) == 1
       task(w,1) = 0;
      elseif strcmp('TRGT', EVvalue{trialStart(w)}) == 1
       task(w,1) = 1;
      else
          disp("not found!")
          disp(EVvalue{trialStart(w)});
      end
      
    end
    
    PreTrig   = round(0.5 * hdr.Fs);
    PostTrig  = round(1.5 * hdr.Fs);
    
    begsample = int32(EVsample(trialStart) - PreTrig);
    endsample = int32(EVsample(trialStart) + PostTrig);

    offset = -PreTrig*ones(size(endsample));
    
    trl = [begsample endsample offset task];
end

