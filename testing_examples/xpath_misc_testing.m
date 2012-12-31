% Misc notes from messing around.
% Get XPath (refs: http://blogs.mathworks.com/community/2010/11/01/xml-and-matlab-navigating-a-tree/)
import javax.xml.xpath.*

% Make XPath expression
factory = XPathFactory.newInstance;
xpath = factory.newXPath;
expression = xpath.compile('records/record/urls/pdf-urls/url');

% Apply the expression to the DOM.
nodeList = expression.evaluate(doc,XPathConstants.NODESET);

% Iterate through the nodes that are returned.
for i = 1:nodeList.getLength
    node = nodeList.item(i-1);
    disp(char(node.getFirstChild.getNodeValue))
end

expression = xpath.compile('records/record/urls/pdf-urls/url');
pdfurlNode = expression.evaluate(doc, XPathConstants.STRING);
pdfurlNode = expression.evaluate(doc, XPathConstants.NODE);

doc.getElementsByTagName('url').item(1).getTextContent;
