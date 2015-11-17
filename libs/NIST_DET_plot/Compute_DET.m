function [Pmiss, Pfa] = Compute_DET(true_scores, false_scores)
%function [Pmiss, Pfa] = Compute_DET (true_scores, false_scores)
%
%  Compute_DET computes the (observed) miss/false_alarm probabilities
%  for a set of detection output scores.
%
%  true_scores (false_scores) are detection output scores for a set of
%  detection trials, given that the target hypothesis is true (false).
%          (By convention, the more positive the score,
%          the more likely is the target hypothesis.)
%
%  Pdet is a two-column matrix containing the detection probability
%  trade-off.  The first column contains the miss probabilities and
%  the second column contains the corresponding false alarm
%  probabilities.
%
%  See DET_usage for examples on how to use this function.

SMAX = 9E99;

% this code is matlab-tized for speed.
% speedup: Old routine 54 secs -> new routine 5.71 secs.
% for 109776 points.

%-------------------------
%Compute the miss/false_alarm error probabilities

num_true = max(size(true_scores));
num_false = max(size(false_scores));

total=num_true+num_false;

Pmiss = zeros(num_true+num_false+1, 1); %preallocate for speed
Pfa   = zeros(num_true+num_false+1, 1); %preallocate for speed

scores(1:num_false,1) = false_scores;
scores(1:num_false,2) = 0;
scores(num_false+1:total,1) = true_scores;
scores(num_false+1:total,2) = 1;

scores=DETsort(scores);

sumtrue=cumsum(scores(:,2),1);
sumfalse=num_false - ([1:total]'-sumtrue);

Pmiss(1) = 0;
Pfa(1) = 1.0;
Pmiss(2:total+1) = sumtrue  ./ num_true;
Pfa(2:total+1)   = sumfalse ./ num_false;

return


function [y,ndx] = DETsort(x,col)
% DETsort Sort rows, the first in ascending, the remaining in decending
% thereby postponing the false alarms on like scores.
% based on SORTROWS

if nargin<1, error('Not enough input arguments.'); end
if ndims(x)>2, error('X must be a 2-D matrix.'); end

if nargin<2, col = 1:size(x,2); end
if isempty(x), y = x; ndx = []; return, end

ndx = (1:size(x,1))';

% sort 2nd column ascending
[v,ind] = sort(x(ndx,2));
ndx = ndx(ind);

% reverse to decending order
ndx(1:size(x,1)) = ndx(size(x,1):-1:1);

% now sort first column ascending
[v,ind] = sort(x(ndx,1));
ndx = ndx(ind);
y = x(ndx,:);



% old routine for reference

function [Pmiss, Pfa] = Old_Compute_DET (true_scores, false_scores)
%function [Pmiss, Pfa] = Compute_DET (true_scores, false_scores)
%
%  Compute_DET computes the (observed) miss/false_alarm probabilities
%  for a set of detection output scores.
%
%  true_scores (false_scores) are detection output scores for a set of
%  detection trials, given that the target hypothesis is true (false).
%          (By convention, the more positive the score,
%          the more likely is the target hypothesis.)
%
%  Pdet is a two-column matrix containing the detection probability
%  trade-off.  The first column contains the miss probabilities and
%  the second column contains the corresponding false alarm
%  probabilities.
%
%  See DET_usage for examples on how to use this function.

SMAX = 9E99;

%-------------------------
%Compute the miss/false_alarm error probabilities

num_true = max(size(true_scores));
true_sorted = sort(true_scores);
true_sorted
true_sorted(num_true+1) = SMAX;

num_false = max(size(false_scores));
false_sorted = sort(false_scores);
false_sorted
false_sorted(num_false+1) = SMAX;

%Pdet = zeros(num_true+num_false+1, 2); %preallocate Pdet for speed
Pmiss = zeros(num_true+num_false+1, 1); %preallocate for speed
Pfa   = zeros(num_true+num_false+1, 1); %preallocate for speed

npts = 1;
%Pdet(npts, 1:2) = [0.0 1.0];
Pmiss(npts) = 0.0;
Pfa(npts) = 1.0;
ntrue = 1;
nfalse = 1;
num_true
num_false
while ntrue <= num_true | nfalse <= num_false
        if true_sorted(ntrue) <= false_sorted(nfalse)
                ntrue = ntrue+1;
        else
                nfalse = nfalse+1;
        end
        npts = npts+1;
%        Pdet(npts, 1:2) = [             (ntrue-1)   / num_true ...
%                           (num_false - (nfalse-1)) / num_false];
        Pmiss(npts) =              (ntrue-1)   / num_true;
        Pfa(npts)   = (num_false - (nfalse-1)) / num_false;
[npts ntrue ntrue-1 nfalse num_false-(nfalse-1) Pmiss(npts) Pfa(npts)]
end

%Pdet = Pdet(1:npts, 1:2);
Pmiss = Pmiss(1:npts);
Pfa   = Pfa(1:npts);

