module VminfosHelper
   def insert_popup_script()
     javascript_tag( "$(function () { $('[rel=popover]').popover({html: true}); });")
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
end
