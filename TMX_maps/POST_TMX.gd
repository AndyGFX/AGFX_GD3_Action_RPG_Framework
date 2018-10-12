extends Node

func post_import(scene):
	print("Post import  script executed ... ")
	# Load scenes to instantiate and add to the level

	for node in scene.get_children():
		# To know the type of a node, check if it is an instance of a base class
		# The addon imports tile layers as TileMap nodes and object layers as Node2D
		if node is TileMap:
			# Process tile layers. E.g. read the ID of the individual tiles and
			# replace them with random variations, or instantiate scenes on top of them
			if node.has_meta("TYPE"):
				var type = node.get_meta("TYPE")
				if type == "SOLID": node.add_to_group("SOLID",true)
			if node.has_meta("Z index"):
				node.z_index = int(node.get_meta("Z index"))


	print("... done")
	# You must return the modified scene
	return scene 