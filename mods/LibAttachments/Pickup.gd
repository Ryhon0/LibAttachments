extends "res://Scripts/Pickup.gd"

func _ready() -> void:
	if attachments && slotData && slotData.itemData && slotData.itemData is WeaponData:
		loadCustomAttachments()
	super()

func loadCustomAttachments() -> void:
	var lib = $/root/LibAttachments
	lib.addCustomAttachmentsToData(slotData.itemData)
	print(lib.attachmentList)

	for a in attachments.get_children():
		var filename = a.name
		for ca in lib.attachmentList:
			if ca.siblingFile != filename:
				continue
			
			var dummyInst = ca.dummyModel.instantiate()
			a.get_parent().add_child(dummyInst)
			dummyInst.transform = a.transform
			dummyInst.translate(ca.offset)
			dummyInst.name = ca.data.file
			dummyInst.visible = false
