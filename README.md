ResponsiveDesign
================

This is the codebase behind my responsive design talk at the Salesforce1 World Tour in London.

While all the components are here and you can drop them into your Saleforce org, its easier to use the Unmanaged Package, available at : 

https://login.salesforce.com/packaging/installPackage.apexp?p0=04ti0000000LHDk

There is a custom tab for blog posts, entitled 'Blog Posts' - add this to your application as appropriate.

The summary field is not currently used.

The the Small/Medium/Large Image Id fields need the id of an attachment on the record (in a future version I'll handle this through Visualforce).  To find out the attachment id, click the View link for the attachment and copy the id from the end of the URL.  In the following example:

https://c.na6.content.force.com/servlet/servlet.FileDownload?file=00P8000000ORL9c

the id is everything after the file=, so 00P8000000ORL9c

You can access the blog posts via the 'BlogHome' Visualforce page.

To make the blogs visible via a Force.com site, add the Blog permission set to the site guest user profile:

1. Navigate to the site config page
2. Click the 'Public Access Settings' link
3. Click the 'Assigned Users' link
4. Click the full name of the site guest user
5. Scroll down to the permission set assignments section
6. Click the 'Edit Assignments' button
7. Add the 'Blog Site' permission set
8. Save the changes

You can then access the page via http://*base_site_url*/ApexHome - replace *base_site_url* with the site URL.

Enjoy!

