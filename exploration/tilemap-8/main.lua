LoadLibrary("Renderer")
LoadLibrary("Sprite")
LoadLibrary("System")
LoadLibrary("Texture")

gRenderer = Renderer.Create()

gTextures =
{
	Texture.Find("tiles_00.png"),
	Texture.Find("tiles_01.png"),
	Texture.Find("tiles_02.png"),
	Texture.Find("tiles_03.png"),
	Texture.Find("tiles_04.png"),
	Texture.Find("tiles_05.png"),
	Texture.Find("tiles_06.png"),
	Texture.Find("tiles_07.png"),
	Texture.Find("tiles_08.png"),
	Texture.Find("tiles_09.png"),
	Texture.Find("tiles_10.png")
}

-- 8x7 map
gMap =
{
	1,1,1,1,5,6,7,1,  -- 1
	1,1,1,1,5,6,7,1,  -- 2
	1,1,1,1,5,6,7,1,  -- 3
	3,3,3,3,11,6,7,1, -- 4
	9,9,9,9,9,9,10,1, -- 5
	1,1,1,1,1,1,1,1,  -- 6
	1,1,1,1,1,1,2,3,  -- 7
}
gMapWidth = 8
gMapHeight = 7

function GetTile(map, rowsize, x, y)
	x = x + 1 -- array adjustment
	return map[x + y * rowsize]
end

local topLeftTile = GetTile(gMap, gMapWidth, 0, 0)
local bottomRightTile = GetTile(gMap, gMapWidth,
 gMapWidth - 1, gMapHeight - 1)

gTexture = Texture.Find("tiles_00.png")
gTileWidth = gTexture:GetWidth()
gTileHeight = gTexture:GetHeight()

gDisplayWidth = System.ScreenWidth()
gDisplayHeight = System.ScreenHeight()

gTop = gDisplayHeight / 2 - gTileHeight / 2
gLeft = -gDisplayWidth / 2 + gTileWidth / 2

gTilesPerRow = math.ceil(gDisplayWidth/gTileWidth)
gTilesPerColumn = math.ceil(gDisplayHeight/gTileHeight)

gTileSprite = Sprite.Create()

function update()
    for j = 0, gTilesPerColumn - 1 do
        for i = 0, gTilesPerRow - 1 do
        	local tile = GetTile(gMap, gMapWidth, i, j)
        	local texture = gTextures[tile]
        	gTileSprite:SetTexture(texture)
            gTileSprite:SetPosition(
            	gLeft + i * gTileWidth,
             	gTop - j * gTileHeight)
            gRenderer:DrawSprite(gTileSprite)
        end
    end
end