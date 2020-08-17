# exports all selected objects per frame.

import bpy
import os

# Set frame to-from.
start_frame = 1
end_frame = 3

mscript_s = '<?xml version="1.0" ?>\n<modelscript>'
mscript_e = '</modelscript>'
mscript_result = ""
addxml_result = ""

mscript_result = mscript_result + mscript_s

for frame in range(start_frame, end_frame+1):
    
    bpy.context.scene.frame_set(frame)
    print("Exporting frame:", frame, "out of", str(end_frame))

    # export to blend file location
    basedir = os.path.dirname(bpy.data.filepath)

    if not basedir:
        raise Exception("Blend file is not saved")

    view_layer = bpy.context.view_layer
    obj_active = view_layer.objects.active
    selection = bpy.context.selected_objects
    
    name = "landscape_" + str(frame)
    fn = os.path.join(basedir, name)

    #Mscript
    mscript_new_line = '<import file="'+name+'.glb" create_objects="true"/>\n<save file="'+name+'.model"/>\n<new/>\n'
    mscript_result = mscript_result + mscript_new_line
    
    #AddXML
    addxml_template = '<unit path="units/pd2_mod_wz/terrain/landscape/'+name+'" unload="true" load="true" />\n<object path="units/pd2_mod_wz/terrain/landscape/'+name+'" unload="true"/>\n<model path="units/pd2_mod_wz/terrain/landscape/'+name+'" unload="true"/>\n'
    addxml_result = addxml_result + addxml_template
        
    bpy.ops.export_scene.gltf(filepath=fn + ".glb", export_yup=False, use_selection=True, export_current_frame=True, export_animations=False )
    

    print(mscript_new_line)
    print("written:", fn)

    view_layer.objects.active = obj_active

    for obj in selection:
        obj.select_set(True)

# FINISHED EXPORT
mscript_result = mscript_result + mscript_e

print("\nMSCRIPT\n"+mscript_result)
print("\nADDXML\n"+addxml_result)

blenderCipher=open('C:\Program Files (x86)\Steam\steamapps\common\PAYDAY 2\Maps\warzone\assets\units\pd2_mod_wz\terrain\landscape\landscape_test.txt','w')
blenderCipher.write(mscript_result)
blenderCipher.close()