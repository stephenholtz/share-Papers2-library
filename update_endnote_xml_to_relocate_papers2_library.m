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
% WARNING: FOR SOME REASON THE RESAVED VERSION OF THE XML CANNOT BE EDITED
% AGAIN, KEEP THE ORIGINAL FOR LATER IMPORTS AS INSTRUCTED BY THE FILE
% NAME OF THE COPIED XML FILE
%
% SLH - 12/2012

debug = false;

% Import the xls as a DOM, and use this to find fields and replace them

% Relies on being in the correct directory
new_article_path = pwd;
xml_file = dir(fullfile(pwd,'*.xml'));

% Error checking on the xml file. Check if exists, and if name works.
if isempty(xml_file);
    errordlg({'.xml file not found in directory',new_article_path}); 
    return;
elseif sum(strcmpi(xml_file(1).name,'xml')) > 1
    errordlg({'.xml file should not contain ''xml'' in filename aside from extension',xml_file});
    return;
else
    % Construct dom if no problems found
    doc = xmlread(xml_file(1).name);
end

% Fix the 'pdf-urls' tag
all_pdf_urls = doc.getElementsByTagName('pdf-urls');
url_prefix = 'file://localhost/';

for i = 1:double(all_pdf_urls.getLength)
	% Retrieve url location
    pdf_url = doc.getElementsByTagName('pdf-urls').item(i-1).getFirstChild.item(0).getTextContent;
    
    if debug
        disp(pdf_url)
    end
    
    [base_dir,article_name,article_extension] = fileparts(char(pdf_url));
    
    %article_name = regexprep(article_name,'\%20',' ');
    
    url_prefix_ind = strfind(base_dir,url_prefix);
    
    article_loc = [new_article_path, filesep, article_name, article_extension];
    
    new_pdf_url = fullfile(base_dir(url_prefix_ind:(url_prefix_ind+numel(url_prefix))-1),article_loc);
        
    doc.getElementsByTagName('pdf-urls').item(i-1).getFirstChild.item(0).setTextContent(new_pdf_url);
    
    % Make sure it worked.
    if debug
        pdf_url = doc.getElementsByTagName('pdf-urls').item(i-1).getFirstChild.item(0).getTextContent;
        disp(pdf_url)
    end
end

% Fix the 'database' tag
database = doc.getElementsByTagName('database');

for i = 1:double(database.getLength)
	% Retrieve url location
    database_path_content = doc.getElementsByTagName('database').item(i-1).getAttributes.item(1).getTextContent;
    if debug
        disp(database_path_content)
    end
    
    [base_dir,database_name,database_extension] = fileparts(char(database_path_content));
        
    url_prefix_ind = strfind(base_dir,url_prefix);
    
    database_loc = [new_article_path, filesep, database_name, database_extension];
    
    doc.getElementsByTagName('database').item(i-1).getAttributes.item(1).setTextContent(database_loc);
    
    % Make sure it worked.
    if debug
        database_path_content = doc.getElementsByTagName('database').item(i-1).getAttributes.item(1).getTextContent;
        disp(database_path_content)
    end
end

% Keep failsafe copy
escaped_name = regexprep(xml_file(1).name,'\s','\\ ');
unix(['mv ' escaped_name ' REMOVE_THIS_TEXT_FOR_NEXT_IMPORT_AND_DELETE_OTHER_XML_' escaped_name]);

% Write the new xml file
xmlwrite(xml_file(1).name,doc)