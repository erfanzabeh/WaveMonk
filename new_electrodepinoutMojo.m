function [ anteriorArray,posteriorArray ] = new_electrodepinoutMojo(format)
% ELECTRODEPINOUTMOJO microelectrode array pinout for Mojo.
%   electrodepinoutMojo(format) will output the array pinouts in either
%   channels or electrode for 'elec' or 'chan' (default) format respectively.
%
%   The first output argument provides the pinout for the anterior array
%   and the second provides the pinout for the posterior array. The top row
%   is oriented anteriorly and the last column is oriented medially.

% author: EHS::20160908

anteriorArrayElecs = [NaN 42	35	28	21	14	7
    48	41	34	27	20	13	6
    47	40	33	26	19	12	5
    46	39	32	25	18	11	4
    45	38	31	24	17	10	3
    44	37	30	23	16	9	2
    43	36	29	22	15	8	1];


posteriorArrayElecs = [NaN   90	83	76	69	62	55
    96	89	82	75	68	61	54
    95	88	81	74	67	60	53
    94	87	80	73	66	59	52
    93	86	79	72	65	58	51
    92	85	78	71	64	57	50
    91	84	77	70	63	56	49];


if strcmp(format,'elec')
    
    anteriorArray = anteriorArrayElecs;
    posteriorArray = posteriorArrayElecs;
    
elseif strcmp(format,'chan')
    els = [78, 88, 68, 58, 56, 48, 57, 38, 47, 28, 37, 27, 36, 18, 45, 17, ...
           46, 8, 35, 16, 24, 7, 26, 6, 25, 5, 15, 4, 14, 3, 13, 2, ...
           77, 67, 76, 66, 75, 65, 74, 64, 73, 54, 63, 43, 72, 53, 62, 12, ...
           61, 44, 52, 33, 10, 34, 41, 42, 31, 32, 21, 22, 11, 23, 51, 55, ...
           96, 87, 95, 86, 94, 85, 93, 84, 92, 83, 91, 82, 90, 81, 89, 80, ...
           79, 71, 69, 70, 59, 60, 50, 49, 40, 39, 30, 29, 19, 20, 1, 9];
    
    chs  = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, ...
            1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, ...
            34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, ...
            33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, ...
            66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, ...
            65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95];
        
    % concatenating arrays in order to operate over all electrodes.
    arrayElecs = [anteriorArrayElecs posteriorArrayElecs];
    arrayChans = zeros(size(arrayElecs));
    % looping over electrodes
    for el = 1:96
        elIdx = arrayElecs==els(el);
        arrayChans(elIdx) = chs(el);
    end
    arrayChans(arrayChans==0) = NaN;
    % splitting concatenated array
    anteriorArrayChans = arrayChans(:,1:size(anteriorArrayElecs,2));
    posteriorArrayChans = arrayChans(:,size(anteriorArrayElecs,2)+1:size(arrayChans,2));
    
    % putting channel arrays in output variable
    anteriorArray = anteriorArrayChans;
    posteriorArray = posteriorArrayChans;
    
else
    error('unspecified format')
end

end

