module VminfosHelper
   def insert_popup_script()
     javascript_tag( "$(function () { $('[rel=popover]').popover({html: true});$('#loginModal').modal(); });")
   end

   def vm_popup_content(vminfo)
     content = content_tag(:a,create_vm_popup_hash(vminfo),:escape => false) do 
       vminfo.name
     end
     content.gsub(/改行/," \<br\>")
   end

   def create_vm_popup_hash(vminfo)
     {
        "rel" => "popover",
        "data-title" => vminfo.name,
        "data-html" => "true",
        "data-content" => "
           Path : #{vminfo.path}#{"改行"}
           NetWork : #{vminfo.network}
        "
     }
   end

   def power_badge_state(powerState)
     color = if powerState == "poweredOn"
        "badge-success"
     elsif powerState == "poweredOff"
        "badge-important"
     else
        "badge-warning"
     end     
     "<span class=\"badge #{color}\">#{powerState}</span>".html_safe
   end
end
