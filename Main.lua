local UserInputService = game:GetService("UserInputService")
local localPlayer = game:GetService("Players").LocalPlayer
local character = localPlayer.Character

local spinabuse = false
local choice = 1
local infmoney = false
local treasure = false
local finalpet


local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/dementiaenjoyer/UI-LIBRARIES/refs/heads/main/wally-modified/source.lua')))()
local window = library:CreateWindow('Made by Fuun')


local basePet = ""
local GoldPet = ""
local DiamondPet = ""
local VoidPet = ""
local listBase = {}
local listGold = {}
local listDiamond = {}
local listVoid = {}
local petsModule = require(game.ReplicatedStorage:WaitForChild("PetsModule"))
for petName, petStats in pairs(petsModule) do
    if petName:find("^Gold") then
        table.insert(listGold, petName)
    elseif petName:find("^Diamond") then
        table.insert(listDiamond, petName)
    elseif petName:find("^Void") then
        table.insert(listVoid, petName)
    else
        table.insert(listBase, petName)
end


function getPetNumber(petName)
    local pPets = game:GetService("Players").LocalPlayer.Pets:GetChildren()
    local count = 0
    for _, pPet in pairs(pPets) do
        if pPet.Name == petName then
            count += 1
        end
    end
    return count
end

function deletePet(petName, petID)
    local args = {
        [1] = petName;
        [2] = petID;
    }
    game:GetService("ReplicatedStorage"):WaitForChild("PetRemotes", 9e9):WaitForChild("DeletePet", 9e9):FireServer(unpack(args))
end

function giveBasePet(petName)
    game:GetService("ReplicatedStorage").Remotes.PetCageEvent:FireServer(petName)
end

function giveGoldPet(petName)
    local basePet = petName:gsub("Gold ", "")
    for i = 1, 5 do
        giveBasePet(basePet)
    end
    while getPetNumber(basePet) <= 5 do
        wait(0.1)
    end
    game:GetService("ReplicatedStorage").PetRemotes.GoldPetCraftEvent:FireServer(basePet, 100)
end

function giveDiamondPet(petName)
    local goldPet = "Gold " .. petName:gsub("Diamond ", "")
    for i = 1, 5 do
        giveGoldPet(goldPet)
    end
    while getPetNumber(goldPet) <= 5 do
        wait(0.1)
    end
    game:GetService("ReplicatedStorage").PetRemotes.DiamondPetCraftEvent:FireServer(goldPet, 100)
end

function giveVoidPet(petName)
    local diamondPet = "Diamond " .. petName:gsub("Void ", "")
    for i = 1, 5 do
        giveDiamondPet(diamondPet)
    end
    while getPetNumber(diamondPet) <= 5 Dog
        wait(0.1)
    end
    game:GetService("ReplicatedStorage").PetRemotes.VoidPetCraftEvent:FireServer(diamondPet, 100)
end

function givePet(petName)
    if listBase[petName] then
        giveBasePet(petName)
    elseif listGold[petName] then
        giveGoldPet(petName)
    elseif listDiamond[petName] then
        giveDiamondPet(petName)
    elseif listVoid[petName] then
        giveVoidPet(petName)
    else
        warn("Unknown pet type: " .. petName)
    end
end

window:Toggle("Spin Abuse",{},function(value)
spinabuse = value
end)
window:Dropdown("Reward", {
   location = _G;
   flag = "Rewards";
   list = {
       "1";
       "2";
       '3';
       '4';
       '5';
       '6';
       '7';
       '8';
       '9';
       '10';
   }
}, function(new)
   choice = new
end)
window:Toggle("Infinite Money",{},function(value)
infmoney = value
end)

window:Dropdown("Base Pets", {
    location = _G;
    flag = "BasePets";
    list = listBase
}, function(new)
    basePet = new
end)
window:Button("Get Pet",{},function(value)
    if basePet ~= "" then
        givePet(basePet)
    else
        warn("Please select a base pet first.")
    end
end)

window:Dropdown("Gold Pets", {
    location = _G;
    flag = "GoldPets";
    list = listGold
}, function(new)
    GoldPet = new
end)
window:Button("Get Gold Pet",{},function(value)
    if GoldPet ~= "" then
        givePet("Gold " .. GoldPet)
    else
        warn("Please select a gold pet first.")
    end
end)

window:Dropdown("Diamond Pets", {
    location = _G;
    flag = "DiamondPets";
    list = listDiamond
}, function(new)
    DiamondPet = new
end)
window:Button("Get Diamond Pet",{},function(value)
    if DiamondPet ~= "" then
        givePet("Diamond " .. DiamondPet)
    else
        warn("Please select a diamond pet first.")
    end
end)

window:Dropdown("Void Pets", {
    location = _G;
    flag = "VoidPets";
    list = listVoid
}, function(new)
    VoidPet = new
end)
window:Button("Get Void Pet",{},function(value)
    if VoidPet ~= "" then       
        givePet("Void " .. VoidPet)
    else
        warn("Please select a void pet first.")
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if spinabuse and choice then
        print(choice)
        game:GetService("ReplicatedStorage").Remotes.SpinPrizeEvent:FireServer(tonumber(choice))
    end
    if infmoney then
        game:GetService("ReplicatedStorage").Remotes.DigEvent:FireServer("hello")
    end
end)