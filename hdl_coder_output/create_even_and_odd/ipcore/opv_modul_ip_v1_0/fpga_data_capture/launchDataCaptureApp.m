% Automatically generated script to launch FPGA Data Capture App
% Instantiate FPGA Data Capture System object
if ~exist('fpgadc_obj','var') || ~isa(fpgadc_obj,'FPGADataCapture') || ~isprop(fpgadc_obj,'TimeStamp') || ~strcmpi(fpgadc_obj.TimeStamp,'20-Apr-2024 21:16:05')
    fpgadc_obj = FPGADataCapture;
end
fpgadc_obj.launchApp;
