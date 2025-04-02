function [areas, M, qnew] = SensitiveTalker_Norm_SBranch_altSort(nareas,E,P,dx,q,cflag);
%SensitiveTalker.m
%B. Story
%Origination date: 06.24.16
%Last updated: 06.24.16 @ 11:01
%
%===============================================================
%This function generates a time-varying area function to produce the
%acoustic targets embedded in matrix P, and follows the time course given
%in matrix E
%
%NAREAS = typically a matrix of area functions where each row is a 44
%section area function; if a matrix, the number of rows must be equal to
%the number of rows in E. NAREAS may also be a single area function; if the
%number of rows in nareas is not equal to those in E, then the first area
%function in NAREAS is used for all iterations. It is also typically the
%case that NAREAS is some form of a neutral vowel shape, but it can also be
%time-varying; e.g. NAREAS could contain an /i/ to /a/ transition and this
%function is being used to simply impose a consonant somewhere along the
%transition.
%
%E = a matrix of EVENT functions; each column represents one time-dependent
%event function, sampling freq is 146 Hz to coincide with TubeTalker; event
%functions can be any time-dependent function that varies between 0 and 1.0
%(the max value must be equal to 1.0).
%
%P = matrix of resonance deflection patterns; each column represents one
%deflection pattern that coincides with the same column in E (i.e., each
%event function must have a coincident deflection pattern). Each column in
%P contains four elements (rows); the first three are delta1, delta2, and
%delta3 - the deflection directions of the first three resonances (they can
%vary between -1 and 1), the fourth element is called "mu" and is the peak
%magnitude of the corresponding event function (this allows the E's to
%always have a max value of 1.0).
%
%dx = section length for each area function element
%
%q = q structure for simulation. Can be set to [] if desired.
%
%OUTPUT variables: 
%areas = new area function matrix based on deformations
%D = a structure containing the deformation functions associated with each event function 
%qnew = new q structure embedded with new area matrix
%
%=========End of Preamble=================================

LocPiri = 6;

%---Determine the number of time points in E---
N = size(E,1);

%---Check if number of area functions in nareas is the same as duration N--
if(size(nareas,1) ~= N)
    nareas = nareas(1,:);
    disp('number of rows in nareas not equal to duration of event functions');
end

%---The fourth row of P contains the mu values. Whenever mu >= 1, the
%DeformationGenerator() will produce a zero area somewhere along the area
%function; thus, these events must be sent to the DeformationGenerator
%AFTER any events where mu<1. The sort function is used to reorder both E
%and P to carry this out; this reordering does not change any aspect of the
%temporal ordering of the events - just the order at any given time step.
%

for n = 1:size(E,2)
    Ep(:,n) = E(:,n)*P(4,n);
end



%---If a q structure is supplied make sure the dx is set to q.dxnew--
if(isempty(q)==0)
    dx = q.dxnew;
    qnew = q;
end

%--Initialize the new area matrix to be filled with ones-------
areas = ones(N,44);

%--Start the time loop----

for n=1:N
    
    %---check to see if NAREAS is a matrix or single area function--
    if(size(nareas,1)>1)
        arN = nareas(n,:);
    else
        arN = nareas;
    end
    
    
    [i,jorder] = sort(Ep(n,:),'ascend');
    Esort = E(n,jorder);
    Psort = P(:,jorder);
    %---Loop through all event functions---
    %---recursively updates arN at this instant of time---
    for k=1:size(Esort)
        
        min(arN)
        ar_thresh = 0.05; %added on 07.05.18; need to understand better why this works
        if(min(arN)>ar_thresh)
            [arN,y,d,g] = DeformationGenerator_Norm_SBranch(Esort(k),arN,dx,Psort(:,k),1,q.piri,LocPiri);
            Mtmp(k).Y(n,:) = y;
            Mtmp(k).C(n,:) = d;
        end
            
    end
    
    %---assign the new area function to the "areas" matrix for storage
    areas(n,:) = arN;
    
end

%---undo the sort for the S structure so that is ordered like the inputs E and P--
% [i,j] = sort(jorder(:));
% for k=1:length(j)
%     M(k) = Mtmp(j(k));
% end
M = 0;
%======Finished with generating new area matrix===============

%---if q structure was supplied, now assign the "areas" matrix to qnew
if(isempty(q)==0)
    qnew.areas = areas;
    qnew.areas(:,45) = 0;
else
    qnew = [];
end

