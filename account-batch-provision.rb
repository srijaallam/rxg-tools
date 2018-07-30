#!/usr/bin/env ruby

require '/space/rxg/console/config/boot_script_environment`

Account.all.each do |a|
  a.apply_usage_plan(UsagePlan.first)
  s.save!
end

