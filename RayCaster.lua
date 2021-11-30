local RayCaster = {}


local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

-- Ensure that OriginPosition is a vector 3, rayDirection is a unit Vector and rayLength is an integer to multiply the direction by
function RayCaster:CastRay(originPosition, rayDirection, rayLength, visualizeRay)
    local rayResult = workspace:Raycast(originPosition, rayDirection * rayLength, raycastParams)

    local rayIntersectionPos = rayResult and rayResult.Position or (originPosition + rayDirection * 5)

    if visualizeRay then
        local dist = (originPosition - rayIntersectionPos).magnitude
        local part = Instance.new("Part")
        part.Parent = workspace
        part.CanCollide = false
        part.Size = Vector3.new(0.1, 0.1, dist)
        part.Material = Enum.Material.Neon
        part.Anchored = true
        part.BrickColor = rayResult == nil and BrickColor.new("Bright red") or BrickColor.new("Bright green")
        part.CFrame = CFrame.lookAt(originPosition, originPosition + rayDirection) * CFrame.new(0, 0, -dist / 2)
        game:GetService("Debris"):AddItem(part, 0.02)
    end

    return rayResult
end



return RayCaster