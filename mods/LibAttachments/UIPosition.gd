extends "res://Scripts/UIPosition.gd"

func _ready() -> void:
	loadCustomAttachments()
	super()

func loadCustomAttachments():
	var weapon : Weapon = owner
	var lib = $/root/LibAttachments
	lib.addCustomAttachmentsToData(weapon.weaponData)

	for a in weapon.attachments.get_children():
		var filename = a.name
		for ca in lib.attachmentList:
			if AttachmentData.Category.keys()[ca.data.category] != Type.keys()[type]:
				continue
			if ca.siblingFile != filename:
				continue
			
			var modelInst = ca.model.instantiate()
			a.get_parent().add_child(modelInst)
			modelInst.transform = a.transform
			modelInst.translate(ca.offset)
			modelInst.name = ca.data.file
			modelInst.visible = false