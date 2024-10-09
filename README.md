# LibAttachments
Road to Vostok mod library for adding custom attachments

## Usage
In your mod autoload:
```gd
func _ready() -> void:
	overrideScript("res://mods/Valday1P87/Preloader.gd") # Add the custom attachment to preloader
	registerAttachments.call_deferred() # Make sure LibAttachments has loaded

func overrideScript(overrideScriptPath : String):
	var script : Script = load(overrideScriptPath)
	script.reload()
	var parentScript = script.get_base_script();
	script.take_over_path(parentScript.resource_path)

func registerAttachments():
	# Check if LibAttachments has been installed
	if !get_tree().root.get_node_or_null("LibAttachments"):
		OS.alert("LibAttachments not found! Please install the LibAttachments mod.")
		queue_free()
		return

	# Add attachment
	$/root/LibAttachments.addSiblingAttachment(load("res://Items/Attachments/1P87/1P87.tres"),\
		load("res://Items/Attachments/1P87/1p87.tscn"),\
		load("res://Items/Attachments/1P87/1P87_Dummy.tscn"),\
		"EXPS",\
		Vector3.UP * 0.011)
	queue_free()
```
`addSiblingAttachment` adds your attachment to every weapon, which has an attachment whose file name (matches Preloader const name) is equal to the provided string (sibling attachment). The attachment models are instantiated at the same position as the sibling + they're translated by the provided offset.