% update_endnote_xml_to_relocate_papers2_library
% Should be located in, and run from within a folder with both a Papers2 
% generated endnote xml file, and the associated media files. 
% 
% i.e. Export a Papers2 library or collection to a destination such as
% /Users/Desktop/master_library, and also use Papers2 to export an endnote
% XML file to this same folder. 
% Drop a copy of this script in as well, compress or give the folder to 
% another Papers2 user, run this script, and then import the endnote XML
% file. All of the pdfs should now be included in the second Papers2 user's
% library along with metadata (and comments, if this was selected on
% export).
%
% All this does is find and replace filepaths: paths from the original
% export library will be changed to reflect the current location of the pdf
% files. Every pdf file from the papers2 library will need to be uniquely
% named, be sure preferences in papers2 are set to add as much to the file
% name as is comfortable.
%
% This currently does NOT work across platforms. Matlab uses the Apache
% Xerces DOM, a java implementation that should not cause any issues. It is
% probably the Papers2 endnote xml creation being different across
% platforms.
%
% Commented if anyone wants to fix it.
% 
% SLH - 12/2012 - stephenlholtz (at) gmail (dot) com

% Import the xls as a DOM, and use this to find fields and replace them

% Relies on being in the correct directory
new_article_path = pwd;
xml_file = dir(fullfile(pwd,'*.xml'));

% Error checking on the xml file. Check if exists, and if name works.
if isempty(xml_file); 
    errordlg({'.xml file not found in directory',new_article_path}); 
    return;
elseif sum(strcmpi(xml_file,'xml')) > 1
    errordlg({'.xml file should not contain ''xml'' in filename aside from extension',xml_file});
    return;
else
    lib_dom = xmlread(xml_file.name);
end

