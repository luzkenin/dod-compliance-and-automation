# encoding: UTF-8

control 'VCRP-70-000003' do
  title 'Envoy must be configured to operate in FIPS mode.'
  desc  "Envoy ships with FIPS 140-2 validated OpenSSL cryptographic libraries
and is configured by default to run in FIPS mode. This module is used for all
crypto operations performed by Envoy including protection of data-in-transit
over the client TLS connection."
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # xmllint --xpath '/config/vmacore/ssl/fips'
/etc/vmware-rhttpproxy/config.xml

    Expected result:

    <fips>true</fips>

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    Navigate to and open /etc/vmware-rhttpproxy/config.xml

    Locate the <config>/<vmacore>/<ssl> block and configure <fips> as follows:

    <fips>true</fips>

    Restart the service for changes to take effect.

    # vmon-cli --restart rhttpproxy
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000014-WSR-000006'
  tag gid: nil
  tag rid: nil
  tag stig_id: 'VCRP-70-000003'
  tag fix_id: nil
  tag cci: ['CCI-000068']
  tag nist: ['AC-17 (2)']

  describe xml("#{input('configXmlPath')}") do
    its(['/config/vmacore/ssl/fips']) { should cmp "#{input('fips')}" }
  end

end

