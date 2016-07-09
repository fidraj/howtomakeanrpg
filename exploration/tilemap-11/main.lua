LoadLibrary("Renderer")
LoadLibrary("Sprite")
LoadLibrary("System")
LoadLibrary("Texture")

gTextureAtlas = Texture.Find("atlas.png")

gTileSize = 32

function GenerateUVs(texture, tileSize)

    local uvs = {}

    local textureWidth = texture:GetWidth()
    local textureHeight = texture:GetHeight()
    local width = tileSize / textureWidth
    local height = tileSize / textureHeight
    local cols = textureWidth / tileSize
    local rows = textureHeight / tileSize

    local u0 = 0
    local v0 = 0
    local u1 = width
    local v1 = height

    for j = 0, rows - 1 do
        for i = 0, cols - 1 do
            table.insert(uvs, {u0, v0, u1, v1})
            u0 = u0 + width
            u1 = u1 + width
        end
        u0 = 0
        v0 = v0 + height
        u1 = width
        v1 = v1 + height
    end
    return uvs
end

gUVs = GenerateUVs(gTextureAtlas, gTileSize)

gMap =
{
    1,1,1,1,5,6, 7,1,   -- 1
    1,1,1,1,5,6,7,1,    -- 2
    1,1,1,1,5,6,7,1,    -- 3
    3,3,3,3,11,6,7,1,   -- 4
    9,9,9,9,9,9,10,1,   -- 5
    1,1,1,1,1,1,1,1,    -- 6
    1,1,1,1,1,1,2,3,    -- 7
}
gMapWidth = 8
gMapHeight = 7


gTileWidth = 32
gTileHeight = 32

gDisplayWidth = System.ScreenWidth()
gDisplayHeight = System.ScreenHeight()

gTop = gDisplayHeight / 2 - gTileHeight / 2
gLeft = -gDisplayWidth / 2 + gTileWidth / 2


function GetTile(map, rowsize, x, y)
    x = x + 1 -- change from  1 -> rowsize
              -- to           0 -> rowsize - 1
    return map[x + y * rowsize]
end

gRenderer = Renderer.Create()

gTileSprite = Sprite.Create()
gTileSprite:SetTexture(gTextureAtlas)

function update()
    for j = 0, gMapHeight - 1 do
        for i = 0, gMapWidth - 1 do
            local tile = GetTile(gMap, gMapWidth, i, j)
            local uvs = gUVs[tile]
            gTileSprite:SetUVs(unpack(uvs))

            gTileSprite:SetPosition(
                gLeft + i * gTileWidth,
                gTop - j * gTileHeight)
            gRenderer:DrawSprite(gTileSprite)
        end
    end
end