extends Node

class CustomAttachment:
	var data : AttachmentData
	var model : PackedScene
	var dummyModel : PackedScene
	var siblingFile : String
	var offset : Vector3

var attachmentList : Array[CustomAttachment] = []

func _ready() -> void:
	overrideScript("res://mods/LibAttachments/Pickup.gd")
	overrideScript("res://mods/LibAttachments/UIPosition.gd")

func addSiblingAttachment(attachment: AttachmentData, model: PackedScene, dummyModel: PackedScene, siblingFile: String, offset: Vector3):
	var a = CustomAttachment.new()
	a.data = attachment
	a.model = model
	a.dummyModel = dummyModel
	a.siblingFile = siblingFile
	a.offset = offset
	attachmentList.append(a)

func overrideScript(overrideScriptPath : String):
	var script : Script = load(overrideScriptPath)
	script.reload()
	var parentScript = script.get_base_script();
	script.take_over_path(parentScript.resource_path)

func addCustomAttachmentsToData(data : WeaponData) -> void:
	for ca in attachmentList:
		if ca.data in data.attachments:
			continue
		
		if data.attachments.any(func(a): return a.file == ca.siblingFile):
			data.attachments.append(ca.data)