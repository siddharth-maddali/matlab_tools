function C = BuildElasticityMatrix(c, varargin)
% BuildElasticityMatrix - Builds stiffness or compliance matrix
%                         For now stiffness only
%   
%   USAGE:
%
%   C = BuildElasticityMatrix(c)
%   C = BuildElasticityMatrix(c, 'Symmetry', symmetry group)
%
%   INPUT:
%
%   c   = (3 x 1) vector with [c11 c12 c44];
%       c44*GAMMAxy = SIGMAxy
%
%   OUTPUT:
%
%   C   = (6 x 6) matrix with properly placed components
%


% default options
optcell = {...
    'Symmetry', 'Cubic', ...
    'Order', '11-22-33-23-13-12', ...
    };

% update option
opts    = OptArgs(optcell, varargin);

if strcmpi(lower(opts.Symmetry), 'cubic')
    c11 = c(1);
    c12 = c(2);
    c44 = c(3);
    
    if strcmp(opts.Order, '11-22-33-23-13-12')
        C   = [...
            c11 c12 c12 0   0   0;
            c12 c11 c12 0   0   0;
            c12 c12 c11 0   0   0;
            0   0   0   c44 0   0;
            0   0   0   0   c44 0;
            0   0   0   0   0   c44;
            ];
    elseif strcmp(opts.Order, '11-22-33-12-13-23')
        C   = [...
            c11 c12 c12 0   0   0;
            c12 c11 c12 0   0   0;
            c12 c12 c11 0   0   0;
            0   0   0   c44 0   0;
            0   0   0   0   c44 0;
            0   0   0   0   0   c44;
            ];
    else
        disp('order not supported');
        return
    end
elseif strcmpi(lower(opts.Symmetry), 'hexagonal')
    c11 = c(1);
    c33 = c(2);
    c12 = c(3);
    c13 = c(4);
    c44 = c(5);
    c66 = (c11 - c12);
    
    if strcmp(opts.Order, '11-22-33-23-13-12')
        C   = [...
            c11 c12 c13 0   0   0;
            c12 c11 c13 0   0   0;
            c13 c13 c33 0   0   0;
            0   0   0   c66 0   0;
            0   0   0   0   c44 0;
            0   0   0   0   0   c44;
            ];
    elseif strcmp(opts.Order, '11-22-33-12-13-23')
        C   = [...
            c11 c12 c12 0   0   0;
            c12 c11 c12 0   0   0;
            c12 c12 c11 0   0   0;
            0   0   0   c44 0   0;
            0   0   0   0   c44 0;
            0   0   0   0   0   c66;
            ];
    else
        disp('order not supported');
        return
    end
else
    disp('symmetry group not supported')
end