function [ anteriorArray,posteriorArray ] = new_electrodepinoutMacDuff(format)
% ELECTRODEPINOUTMOJO microelectrode array pinout for Mojo.
%   electrodepinoutMojo(format) will output the array pinouts in either
%   channels or electrode for 'elec' or 'chan' (default) format respectively.
%
%   The first output argument provides the pinout for the anterior array
%   and the second provides the pinout for the posterior array. The top row
%   is oriented anteriorly and the last column is oriented medially.

% author: EHS::20160908


anteriorArrayElecs = [NaN	45	40	35	30	25	20	15	10	5
                        48	44	39	34	29	24	19	14	9	4
                        47	43	38	33	28	23	18	13	8	3
                        46	42	37	32	27	22	17	12	7	2
                        NaN	41	36	31	26	21	16	11	6	1
                        ];


posteriorArrayElecs = [NaN	93	88	83	78	73	68	63	58	53
                        96	92	87	82	77	72	67	62	57	52
                        95	91	86	81	76	71	66	61	56	51
                        94	90	85	80	75	70	65	60	55	50
                        NaN	89	84	79	74	69	64	59	54	49
                        ];


if strcmp(format,'elec')
    
    anteriorArray = anteriorArrayElecs;
    posteriorArray = posteriorArrayElecs;
    
elseif strcmp(format,'chan')
    
    els = [78, 88, 68, 58, 56, 48, 57, 38, 47, 28, 37, 27, 36, 18, 45, 17, ...
           46, 8, 35, 16, 24, 7, 26, 6, 25, 5, 15, 4, 14, 3, 13, 2, ...
           77, 67, 76, 66, 75, 65, 74, 64, 73, 54, 63, 53, 72, 43, 62, 55, ...
           61, 44, 52, 33, 51, 34, 41, 42, 31, 32, 21, 22, 11, 23, 10, 12, ...
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



