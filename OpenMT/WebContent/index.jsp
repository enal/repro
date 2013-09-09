<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!-- access: (http://localhost:8080/OpenMT/) http://localhost:<port>/<project name>/index -->

<sx:head/>
<html>
<head>
    <title>OpenMT - Prototype</title>
</head>
<body>
 
<h1>OpenMT</h1>
<s:actionerror/>


<!-- <sx:autocompleter size="1" list="countries" name="country"/> -->

 
<s:form action="start" method="post">	
    <s:textfield name="contact.firstName" label="Firstname"/>
    <s:textfield name="contact.lastName" label="Lastname"/>
    <s:textfield name="contact.emailId" label="Email"/>
    <s:textfield name="contact.source" label="Source"/>
    <s:textfield name="contact.target" label="Target"/>
    <s:textfield name="contact.apiKey" label="API-Key"/>
   <!--   <s:textfield name="contact.cellNo" label="Cell No."/>
    <s:textfield name="contact.website" label="Homepage"/>
    <s:textfield name="contact.birthDate" label="Birthdate"/> -->
    <s:textarea name="contact.mapper" label="Mappings" cols="120" rows="20">
        <s:param name="value">
            var jsontTemplate = { 
	"self": "{@schema($)}",
	"schema": function(obj){ 
		return JSON.stringify({
			"title": input["title"],
			"notes": input["notes"],
			"name": input["name"],
			"tags": input["tags"],
			"author": input["author"],
			"author_email": input["author_email"],
			"maintainer": input["maintainer"],
			"maintainer_email":input["maintainer_email"],
			"license_id": input["license_id"],
			"url": input["url"],
			"state": input["state"],
			
			"resources":  (function() {
				var resources = new Array();
				
				for (res in input["resources"]) {
					var test = new Object();
					test.description = input["resources"][res]["description"]; 
					test.format = input["resources"][res]["format"];
					test.url = input["resources"][res]["url"];
					resources.push(test);
				} 
				return resources;})(),
			"extras": {
				"geographic_coverage": input["extras"]["geographic_coverage"],
				"country": "wieeee",
				"language": "german",
				"sources": input["ckan_url"],
				"geographical_granularity": input["extras"]["geographical_granularity"],
				"geographical_coverage": input["extras"]["geographic_coverage"],
				"temporal_granularity": input["extras"]["temporal_granularity"],
				"temporal_coverage_from": input["extras"]["temporal_coverage_from"],
				"temporal_coverage_to": input["extras"]["temporal_coverage_to"],
				"data_collection_type": "Harvest",
				"data_collection_description": "NEW: imported by engage CKAN Importer",
				"published_via": "http://data.gov.uk"
			}
		});
	}
};


            
        </s:param>
    </s:textarea>    
    <s:submit value="Add User" align="center"/>
</s:form>
 
 
<h2>Users</h2>
<table>
<tr>
    <th>Name</th>
    <th>Email</th>
    <th>Source</th>
    <th>Target</th>
    <th>API-Key</th>
 <!--   <th>Cell No.</th>
      <th>Birthdate</th>
    <th>Homepage</th> -->
    <th>Delete</th>
</tr>
<s:iterator value="contactList" var="contact">
    <tr>
        <td><s:property value="lastName"/>, <s:property value="firstName"/> </td>
        <td><s:property value="emailId"/></td>
       <!--   <td><s:property value="cellNo"/></td>
        <td><s:property value="birthDate"/></td>
        <td><a href="<s:property value="website"/>">link</a></td> -->
        <td><s:property value="source"/></td>
        <td><s:property value="target"/></td>
        <td><s:property value="apiKey"/></td>
        <td><a href="delete?id=<s:property value="id"/>">delete</a></td>
    </tr>
</s:iterator>
</table>
</body>
</html>