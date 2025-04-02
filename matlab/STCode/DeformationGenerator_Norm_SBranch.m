function [arN,y,d,g] = DeformationGenerator_Norm_SBranch(En,ar0,dx,p,cflag,Ap1,LocPiri);
%DeformationGenerator.m
%B. Story
%Origination date: 06.24.16
%Last updated: 07.08.16 @ 09:40
%
%=============================================
%
%This function produces a deformation function AT TIME INSTANT "n" that is applied to the input area
%function ar0. The deformation is based on calculating the sensitivity
%functions for the given ar0 and then producing a linear combination of
%them, scaled by the first three values in "p"
%
%En = event function magnitude at time instant "n" (best to use a Gaussian I think)
%
%p = vector of four numbers to specify polarity and magnitude of each
%sensitivity function, and p(4) is mu = magnitude of the movement.
%
%Example: [-1 1 1 1] specifies downward deflection for F1, and upward
%deflections for F2 and F3 with movement magnitude of 1.0 (should produce a
%stop consonant)
%
%OUTPUT variables:
%arN = new area function based on deformations
%b = deformation function superimposed on ar0 to produce arN
%c = constraint function

%========End of Preamble======================

%====Set up piriform sinus=====

if(isempty(Ap1) == 0)
    if(length(Ap1) == 1)
        Ap = [Ap1 .8 .7 .4] + 1e-6;
    else
        Ap = Ap1 + 1e-6;
    end
else
    Ap = [0 .8 .7 .4];
end

Lp = dx*ones(1,4);

%=====A set of constraints=====

%---epilarynx constraint-------
% g1 = cgauss([1:44],1,5,6);
% g1(1:4) = 0;

%g1 = cgauss([1:44],1,4,5);
%g1(1:3) = 0;

%g1 = cgauss([1:44],1,1,15);

g1 = cgauss([1:44],1,4,10);
g1(1:4) = 0;

g1 = g1(:);



%----pharyngeal constraint-----
g2 = MovementTrajGaussian(44,37,35,1.);
%g2 = MovementTrajGaussian(44,37,25,1.);
%g2 = MovementTrajGaussian(44,20,25,2.5);
g2 = g2(:);

%-lip constraint----
g3 = cgauss([1:44],.8,44,15);
g3 = g3(:);

%----overall constraint------
%Don't change - bhs 06.29.18 - use for /u/
mc = MovementTrajCos([1 15 26 44],[0 1 1 .2]);
g4 = mc(:);

%Need to consider this as a normal constraint to limit too much pharyngeal
%movement
g5 = MovementTrajCos([1 15 35 44],[0.25 0.25 1 1]);
g5 = g5(:);

%Ventriloquist constraint
g6 = cgauss([1:44],1,44,25);
g6 = g6(:);

%Random constraint
g7 = cgauss([1:44],.2,44,35);
g7 = g7(:);

%----combine constraints---

if(cflag == 0)
    g = ones(1,44);
elseif(cflag == 1)
    g = g1;
elseif(cflag == 2)
    g = g2;
elseif(cflag == 3)
    g = g3;
elseif(cflag == 12)
    g = g1.*g2;
elseif(cflag == 13)
    g = g1.*g3;
elseif(cflag == 23)
    g = g2.*g3;
elseif(cflag == 123)
    g = g1.*g2.*g3;
elseif(cflag == 4);
    g = g4;
elseif(cflag == 5)
    g = g5;
elseif(cflag == 15)
    g = g1.*g5;
elseif(cflag == 35)
    g = g3.*g5;
elseif(cflag == 135)
    g = g1.*g3.*g5;
elseif(cflag == 6)
    g = g6;
elseif(cflag == 16)
    g = g1.*g6;
elseif(cflag == 7)
    g = g7;
elseif(cflag == 17)
    g = g1.*g7;
else
    g = ones(1,44);
    disp('cflag should be 0,1,2,3,12,13,23, or 123; no constraint set');
end



%=============================

mu = p(end);
En = En*mu;


if(min(ar0)>0)
    
    [S,Bx,K,P,fmts,Press,Flow] = sens_functions_sbranch(ar0(:),dx,Ap,Lp,LocPiri,'y');
    
    
    %---impose constraint function here instead of on "a" - may not matter--
    if(cflag > 0)
        S(:,1) = S(:,1).*g(:);
        S(:,2) = S(:,2).*g(:);
        S(:,3) = S(:,3).*g(:);
    end
    
    %Normalize sensitivity functions---
    S(:,1) = NormalizeSensFunction(S(:,1));
    S(:,2) = NormalizeSensFunction(S(:,2));
    S(:,3) = NormalizeSensFunction(S(:,3));
      
    
    %---generate the deformation function--
    y = (p(1)*S(:,1)+p(2)*S(:,2)+p(3)*S(:,3))';
    
    %---impose constraint function--
    %a = a.*g;
    
    %---transform sensitivity function sum into deformation pattern--
    d = -En/min(y)*y + 1;
    
    %---may a useful alternative for vowels (??) ------
    %d = En/max(y)*y + 1;
    
    %---impose deformation function on the current vocal tract shape--
    arN = d(:).*ar0(:);
    
    %--Not sure if this is necessary - maybe for vowels
    %     if(mu < 1)
    %         arN = LimitSmallAreas(arN(:)');
    %     end
    
    %---assure that no areas are less than zero (this occurs when mu > 1) ---
    arN(arN<0) = 0;
    
else
    arN = ar0;
    b = [];
end

