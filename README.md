# APC-Propeller-Model-Creator
APC_Propeller_Model_Creator is a top-level script to create MATLAB interpolant data from APC propeller .dat files

% File Information:
%   APC_Propeller_Model_Creator - top-level script to create MATLAB 
%   interpolant data from APC propeller .dat files

% REFERENCES: 
%   [1] Comer, A., Atkinson, Z., Bhandari, P., Miller, Z., Harp, E.
%   Development of a Simulation to Flight Workflow for Subscale Flight 
%   Testing of Experimental Control Laws
%   AIAA SCITECH 2026 Forum | AIAA 2026-2063
%   https://doi.org/10.2514/6.2026-2063

% DESCRIPTION: 
%   This script wraps together 2 seperate scripts:
%   1) ParseAPCPropData.p - responsible for creating interpolated tables
%   2) Create_IPPM.p - responsible for creating surface equations
%   to create surface equations [Output] = f(N,V) as described in Eq. (11)
%   of Ref. [1]. These surface equations describe Thrust, Torque, and Power
%   as functions of RPM (N) and axial velocity (V) [m/s]. Additionally, a 
%   surface equation is developed to estimate the required RPM based on a 
%   required thrust as follows: [N] = f(T,V), where T is requested thrust 
%   [N] and V is the axial velocity [m/s].

% INPUTS: 
%   FitRPMRange - prop rotational speed of interest for fitting [rpm]

% OUTPUTS:
%   RefTbl_PER3_DxP(I) - interpolates APC propeller data into MATLAB table
%   PropData_DxP(I) - identified surface equation coefficients (Ref. [1])
%   RefTbl - workspace variable containing identified APC prop data
%   FitComp - response surface equation (RSE) data estimates, including 
%   comparison data and value ratios (measures of fit)

% WRITTEN BY:
%   Anthony M. Comer
%   Oklahoma State University
%   Simulation to Flight Applied Research (S2FAR) Laboratory
%   Email: anthony.comer@okstate.edu

% HISTORY:
%   15 JUL 2026 - created, commented, and debugged, AMC

%   Questions? Reach out!

% ***WE KINDLY REQUEST YOU REFERENCE THIS IF USED TO SUPPORT YOUR WORK!***
