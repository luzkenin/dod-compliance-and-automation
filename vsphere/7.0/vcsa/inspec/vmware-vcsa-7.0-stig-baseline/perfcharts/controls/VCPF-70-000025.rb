# encoding: UTF-8

control 'VCPF-70-000025' do
  title 'Performance Charts must be configured to not show error reports.'
  desc  "Web servers will often display error messages to client users,
including enough information to aid in the debugging of the error. The
information given back in error messages may display the web server type,
version, patches installed, plug-ins and modules installed, type of code being
used by the hosted application, and any backends being used for data storage.

    This information could be used by an attacker to blueprint what type of
attacks might be successful. Therefore, Performance Charts must be configured
with a catch-all error handler that redirects to a standard \"error.jsp\".
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # xmllint --xpath
'/Server/Service/Engine/Host/Valve[@className=\"org.apache.catalina.valves.ErrorReportValve\"]'
/usr/lib/vmware-perfcharts/tc-instance/conf/server.xml

    Expected result:

    <Valve className=\"org.apache.catalina.valves.ErrorReportValve\"
showServerInfo=\"false\" showReport=\"false\"/>

    If the output of the command does not match the expected result, this is a
finding.
  "
  desc  'fix', "
    Navigate to and open:

    /usr/lib/vmware-perfcharts/tc-instance/conf/server.xml

    Locate the following Host block:

    <Host ...>
    ...
    </Host>

    Inside this block, add the following on a new line:

    <Valve className=\"org.apache.catalina.valves.ErrorReportValve\"
showServerInfo=\"false\" showReport=\"false\"/>

    Restart the service with the following command:

    # vmon-cli --restart perfcharts
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000266-WSR-000159'
  tag gid: nil
  tag rid: nil
  tag stig_id: 'VCPF-70-000025'
  tag fix_id: nil
  tag cci: ['CCI-001312']
  tag nist: ['SI-11 a']

  describe xml("#{input('serverXmlPath')}") do
    its(['Server/Service/Engine/Host/Valve[@className="org.apache.catalina.valves.ErrorReportValve"]/@showServerInfo']) { should cmp "false" }
    its(['Server/Service/Engine/Host/Valve[@className="org.apache.catalina.valves.ErrorReportValve"]/@showReport']) { should cmp "false" }
  end

end

