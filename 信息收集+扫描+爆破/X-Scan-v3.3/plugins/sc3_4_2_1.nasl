#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(34443);
  script_version("$Revision: 1.3 $");
  script_cve_id("CVE-2008-4367");
  script_xref(name:"OSVDB", value:"50375");

  script_name(english:"Security Center < 3.4.2.1 Directory Traversal Arbitrary File Access");
  script_summary(english:"Checks version of SC3");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is prone to
directory traversal attacks." );
 script_set_attribute(attribute:"description", value:
"The version of Tenable Security Center installed on the remote host
appears to be earlier than 3.4.2.1.  Such versions contain two
vulnerabilities that allow a user who was logged into the Security
Center to obtain system files." );
 script_set_attribute(attribute:"see_also", value:"http://www.tenablesecurity.com/news/rssview.php?id=174" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Security Center 3.4.2.1 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:S/C:P/I:N/A:N" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("http_func.inc");
include("http_keepalive.inc");


port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);
if (!can_host_php(port:port)) exit(0);


req = http_get(item:"/sc3/console.php?psid=101", port:port);
res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
if (res == NULL) exit(0);

if ("title>Tenable Network Security's Security Center " >!< res) exit(0);

version = strstr(res, "title>Tenable Network Security's Security Center ") -
    "title>Tenable Network Security's Security Center ";
version = version - strstr(version, "</title>");
if (!version) exit(0);

if (version =~ "^3\.[0-3]($|[^0-9])") security_warning(port);
else if (version =~ "^3\.4")
{
  # nb: version.txt first was added in 3.4.2.1.
  req2 = http_get(item:"/version.txt", port:port);
  res2 = http_keepalive_send_recv(port:port, data:req2, bodyonly:FALSE);
  if (!isnull(res2) && "Security Center" >!< res2) security_warning(port);
}
