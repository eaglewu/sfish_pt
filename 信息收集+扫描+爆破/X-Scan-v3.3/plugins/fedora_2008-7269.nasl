
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-7269
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(34101);
 script_version ("$Revision: 1.2 $");
script_name(english: "Fedora 8 2008-7269: xastir");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-7269 (xastir)");
 script_set_attribute(attribute: "description", value: "Xastir is a graphical application that interfaces HAM radio
and internet access to realtime mapping software.

Install XASTIR if you are interested in APRS(tm) and HAM radio
software.

-
Update Information:

Multiple insecure temporary file usage flaws were identified in the get-
maptools.sh and get_shapelib.sh scripts shipped in xastir packages.    As those
scripts are not needed with Fedora-distributed xastir packages (they automate
installation of libraries used by xastir, which are provided in the Fedora
archive in the pre-packaged RPM format), they were removed.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

script_summary(english: "Check for the version of the xastir package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"xastir-1.9.2-8.fc8", release:"FC8") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
