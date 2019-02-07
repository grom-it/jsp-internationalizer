JSP Internationalizer Utility
==

This tool should help you to extract static texts from JSP templates and tag-files. 

The extracted texts are stored in a resource file together with a unique key and the source string is replaced with a \<spring:message\> tag in the processed files.
Since the results are not yet perfect and manual validation is still required all changes will only happen in copies of the template files named 'filename.translated.jsp'.


Features
--

- replace static text in html elements and attributes by message tag
- replace static text in JSP attributes by a variable and a corresponding message tag that declares that variable
- output Java resource file with translations
