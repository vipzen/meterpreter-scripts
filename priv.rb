require 'msf/core/post/windows/priv'
require 'msf/core/post/windows/registry'

uac_level = "ConsentPromptBehaviorAdmin" # uac level key
uac_hivek = "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" # uac hive key
check_success = registry_getvaldata("#{uac_hivek}","#{uac_level}")

admin_group = is_in_admin_group?
admin_check = is_admin?
uac_check = is_uac_enabled?
system_check = is_system?

if(system_check)
print_good("Running as SYSTEM: true")
else
print_status("Running as SYSTEM: false")
end

if(admin_check)
print_good("Admin token: true")
else
print_status("Admin token: false")

	if(admin_group)
	print_good('Admin group: true')

		if(admin_group == true) && (admin_check == false)

		    if check_success == 2
		      	print_status("UAC set to: #{check_success} (always notify -> difficult to exploit)")
		  	elsif check_success.nil?
		      	print_status("UAC DWORD DATA EMPTY (NON-UAC-SYSTEM?)")
		    else
		      	print_good("UAC set to: #{check_success} (default -> easily exploitable :)")
		    end
		end
	else
	print_status("Admin group: false")
	end

end