LoadLibrary("Renderer")
LoadLibrary("Sprite")
LoadLibrary("Texture")
LoadLibrary("System")

gRenderer = Renderer:Create()

gTileSprite = Sprite:Create()
gGrassTexture = Texture.Find("grass_tile.png")
gTileWidth = gGrassTexture:GetWidth()
gTileHeight = gGrassTexture:GetHeight()

gDisplayWidth = System.ScreenWidth()
gDisplayHeight = System.ScreenHeight()

gTilesPerRow = math.ceil(gDisplayWidth/gTileWidth)
gTilesPerColumn = math.ceil(gDisplayHeight/gTileHeight)

gLeft = -gDisplayWidth / 2 + gTileHeight / 2
gTop = gDisplayHeight / 2 - gTileHeight / 2

gTileSprite:SetTexture(gGrassTexture)

function update()
	for i = 0, gTilesPerRow - 1 do
		for j = 0, gTilesPerColumn - 1 do
			
			gTileSprite:SetPosition(
				gLeft + i * gTileWidth,
				gTop - j * gTileHeight)

			gRenderer:DrawSprite(gTileSprite)
		end
	end
end