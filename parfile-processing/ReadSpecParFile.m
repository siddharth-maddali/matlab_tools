function pardata = ReadSpecParFile(fname, varargin)
% ReadSpecParFile - read par file generated from python
%
%   INPUT:
%
%   fname
%       name of the spec generated par file name
%
%   numchs
%       number of channels recorded in the spec generated par file (excluding the
%       date / time channel)
%
%   OUTPUT:
%
%   pardata
%       spec par file data in struct arrary.
%
%   The input arguments can be followed by a list of
%   parameter/value pairs which control certain plotting
%   features.  Options are:
%
%   'Version'               version of spec metadata file (par file).
%                           example: (coratella_feb15).

% default options
optcell = {...
    'Version', 'none', ...
    'NumChannels', 58, ...
    };

% update option
opts    = OptArgs(optcell, varargin);

fid     = fopen(fname, 'r','n');
%%% MAKE FORMAT STRING
switch lower(opts.Version)
    case 'none'
        disp('user specified par file format')
        numchs      = opts.NumChannels;
        
        fmtstring   = '%s %s %s %s %d %s';
        for i = 1:1:numchs
            fmtstring   = [fmtstring, ' %f'];
        end
        
        %%% READ IN DATA USING FORMAT STRING
        textdata  = textscan(fid, fmtstring);
        
        %%% PARSE DATA
        pardata.day     = textdata{1};
        pardata.month   = textdata{2};
        pardata.date    = textdata{3};
        pardata.time    = textdata{4};
        pardata.year    = textdata{5};
        pardata.froot   = textdata{6};
        pardata.chs     = zeros(length(pardata.date), numchs);
        for i = 1:1:numchs
            pardata.chs(:,i)  = textdata{i+6};
        end
    case 'coratella_feb15'
        disp(opts.Version)
        numchs      = opts.NumChannels;
        
        fmtstring   = '%s %s %s %s %d %s';
        for i = 1:1:numchs
            fmtstring   = [fmtstring, ' %f'];
        end
        
        %%% READ IN DATA USING FORMAT STRING
        textdata  = textscan(fid, fmtstring);
        
        %%% PARSE DATA
        pardata.day     = textdata{1};
        pardata.month   = textdata{2};
        pardata.date    = textdata{3};
        pardata.time    = textdata{4};
        pardata.year    = textdata{5};
        pardata.froot   = textdata{6};
        
        pardata.GE1num  = textdata{7};
        pardata.GE2num  = textdata{8};
        pardata.GE3num  = textdata{9};
        pardata.GE4num  = textdata{10};
        pardata.GE5num  = textdata{11};
        
        pardata.ExpTime = textdata{12};
        pardata.NumFrames       = textdata{13};
        pardata.SAXS_num_ini    = textdata{14};
        pardata.SAXS_num_fin    = textdata{15};
        
        pardata.conXH   = textdata{16};
        pardata.conYH   = textdata{17};
        pardata.conZH   = textdata{18};
        pardata.conUH   = textdata{19};
        pardata.conVH   = textdata{20};
        pardata.conWH   = textdata{21};
        
        pardata.S0  = textdata{22};
        pardata.S1  = textdata{23};
        pardata.S2  = textdata{24};
        pardata.S3  = textdata{25};
        pardata.S5  = textdata{26};
        pardata.S4  = textdata{27};
        pardata.S6  = textdata{28};
        pardata.S8  = textdata{29};
        pardata.S20 = textdata{30};
        pardata.S18 = textdata{31};
        
        pardata.p1Hs    = textdata{32};
        pardata.p1Vs    = textdata{33};
        pardata.p2Hs    = textdata{34};
        pardata.p2Vs    = textdata{35};
        
        pardata.Iring   = textdata{36};
        pardata.Energy  = textdata{37};
        pardata.Energy_cal  = textdata{38};
        
        pardata.preamp1 = textdata{39};
        pardata.preamp2 = textdata{40};
        pardata.preamp3 = textdata{41};
        pardata.preamp4 = textdata{42};
        pardata.preamp5 = textdata{43};
        pardata.preamp6 = textdata{44};
        pardata.preamp7 = textdata{45};
        pardata.preamp8 = textdata{46};
        
        pardata.samXE       = textdata{47};
        pardata.samYE       = textdata{48};
        pardata.samZE       = textdata{49};
        pardata.samRXE      = textdata{50};
        pardata.samRZE      = textdata{51};
        pardata.samX2E      = textdata{52};
        pardata.samZ2E      = textdata{53};
        pardata.phi         = textdata{54};
        
        pardata.keyence1    = textdata{55};
        pardata.keyence2    = textdata{56};
        pardata.cross       = textdata{57};
        pardata.load        = textdata{58};
        pardata.mts3        = textdata{59};
        pardata.mts4        = textdata{60};
        
        pardata.temp1       = textdata{61};
        pardata.temp2       = textdata{62};
        pardata.temp3       = textdata{63};
        pardata.fur_output  = textdata{64};
    otherwise
        disp('format not implemented')
end
fclose(fid);
% 
% p date(),GE_fname,GE_fnum1,GE_fnum2,GE_fnum3,GE_fnum4,GE_fnum5,GE_tframe,GE_Nframe,saxs_fnum_start,saxs_fnum_end,\
%         A[conXH],A[conYH],A[conZH],A[conUH],A[conVH],A[conWH],\
%         S[0],S[1],S[2],S[3],S[5],S[4],S[6],S[8],S[20],S[18],\
%         p1Hs,p1Vs,p2Hs,p2Vs,Iring,energy,energy_cal,\
%         preamp1,preamp2,preamp3,preamp4,preamp5,preamp6,preamp7,preamp8,\
%         sammy_x,sammy_y,sammy_z,sammy_Rx,sammy_Rz,sammy_x2,sammy_z2,sammy_phi,\
%         keyence1,keyence2,cross,load,mts3,mts4,temp1,temp2,temp3,fur_output