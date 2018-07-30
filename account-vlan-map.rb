#!/usr/bin/env ruby

# This script creates a VTA for each account in data.csv to map accounts to vlans.

# get rails env
require '/space/rxg/console/config/boot_script_environment'
require 'csv'

d = File.read('./data.csv')
csv = CSV.parse(d, :headers => true)
mac_base = '00:00:00:00:'
c1 = 1
c2 = 1
csv.each do |r|
  if c2 == 100
    c2 = 0
    c1 += 1
  end
  thismac = mac_base + format('%02d', c1) + ':' + format('%02d', c2)
  v = VlanTagAssignment.new
  v.static = true
  v.mac = thismac
  v.tag = r[1].to_i
  v.vlan = Vlan.find_by(:name => 'resident')
  v.account = Account.find_by(:login => r[0].downcase)
  v.radius_server = RadiusServer.find_by(:name => 'residents')
  v.save!
  puts r[0] + ' in vlan ' + r[1] + ' with mac ' + thismac
  c2 += 1
end
