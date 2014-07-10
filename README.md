#update_endnote_xml_to_relocate_papers2_library
Should be located in, and run from within a folder with both a Papers2 generated endnote xml file, and the associated media files. 

1. Export a Papers2 library or collection to a destination such as /Users/Desktop/master_library, and also use Papers2 to export an endnote XML file to this same folder. 
2. Drop a copy of this script in as well, compress or give the folder to  another Papers2 user, run this script, and then import the endnote XML file. All of the pdfs should now be included in the second Papers2 user's library along with metadata (and comments, if this was selected on export). 

All this does is find and replace filepaths: paths from the original export library will be changed to reflect the current location of the pdf files. Every pdf file from the papers2 library will need to be uniquely named, be sure preferences in papers2 are set to add as much to the file name as is comfortable.

NOTE: FOR SOME REASON THE RESAVED VERSION OF THE XML CANNOT BE EDITED AGAIN, KEEP THE ORIGINAL FOR LATER IMPORTS AS INSTRUCTED BY THE FILE NAME OF THE COPIED XML FILE

SLH - 12/2012
