
local function AddFolder(path)
	for k, v in pairs(file.Find("../" .. path .. "*")) do
		resource.AddFile(path .. v);
	end
end

resource.AddFile("resource/fonts/whiskey.ttf");