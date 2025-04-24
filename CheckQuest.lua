if game.PlaceId == 2753915549 then
    World1 = true
elseif game.PlaceId == 4442272183 then
    World2 = true
elseif game.PlaceId == 7449423635 then
    World3 = true
end
_G.MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
if World1 then
    if _G.MyLevel == 1 or _G.MyLevel <= 9 then

        _G.Mon = "Bandit"
        _G.LevelQuest = 1
        _G.NameQuest = "BanditQuest1"
        _G.NameMon = "Bandit"
        _G.CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
        _G.CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
    elseif _G.MyLevel == 10 or _G.MyLevel <= 14 then

        _G.Mon = "Monkey"
        _G.LevelQuest = 1
        _G.NameQuest = "JungleQuest"
        _G.NameMon = "Monkey"
        _G.CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
        _G.CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
    elseif _G.MyLevel == 15 or _G.MyLevel <= 29 then

        _G.Mon = "Gorilla"
        _G.LevelQuest = 2
        _G.NameQuest = "JungleQuest"
        _G.NameMon = "Gorilla"
        _G.CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
        _G.CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
    elseif _G.MyLevel == 30 or _G.MyLevel <= 39 then

        _G.Mon = "Pirate"
        _G.LevelQuest = 1
        _G.NameQuest = "BuggyQuest1"
        _G.NameMon = "Pirate"
        _G.CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
        _G.CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
    elseif _G.MyLevel == 40 or _G.MyLevel <= 59 then

        _G.Mon = "Brute"
        _G.LevelQuest = 2
        _G.NameQuest = "BuggyQuest1"
        _G.NameMon = "Brute"
        _G.CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
        _G.CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
    elseif _G.MyLevel == 60 or _G.MyLevel <= 74 then

        _G.Mon = "Desert Bandit"
        _G.LevelQuest = 1
        _G.NameQuest = "DesertQuest"
        _G.NameMon = "Desert Bandit"
        _G.CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
        _G.CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
    elseif _G.MyLevel == 75 or _G.MyLevel <= 89 then

        _G.Mon = "Desert Officer"
        _G.LevelQuest = 2
        _G.NameQuest = "DesertQuest"
        _G.NameMon = "Desert Officer"
        _G.CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
        _G.CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
    elseif _G.MyLevel == 90 or _G.MyLevel <= 99 then

        _G.Mon = "Snow Bandit"
        _G.LevelQuest = 1
        _G.NameQuest = "SnowQuest"
        _G.NameMon = "Snow Bandit"
        _G.CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
        _G.CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
    elseif _G.MyLevel == 100 or _G.MyLevel <= 119 then

        _G.Mon = "Snowman"
        _G.LevelQuest = 2
        _G.NameQuest = "SnowQuest"
        _G.NameMon = "Snowman"
        _G.CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
        _G.CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
    elseif _G.MyLevel == 120 or _G.MyLevel <= 149 then

        _G.Mon = "Chief Petty Officer"
        _G.LevelQuest = 1
        _G.NameQuest = "MarineQuest2"
        _G.NameMon = "Chief Petty Officer"
        _G.CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        _G.CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
    elseif _G.MyLevel == 150 or _G.MyLevel <= 174 then

        _G.Mon = "Sky Bandit"
        _G.LevelQuest = 1
        _G.NameQuest = "SkyQuest"
        _G.NameMon = "Sky Bandit"
        _G.CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
        _G.CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
    elseif _G.MyLevel == 175 or _G.MyLevel <= 189 then

        _G.Mon = "Dark Master"
        _G.LevelQuest = 2
        _G.NameQuest = "SkyQuest"
        _G.NameMon = "Dark Master"
        _G.CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
        _G.CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
    elseif _G.MyLevel == 190 or _G.MyLevel <= 209 then

        _G.Mon = "Prisoner"
        _G.LevelQuest = 1
        _G.NameQuest = "PrisonerQuest"
        _G.NameMon = "Prisoner"
        _G.CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
        _G.CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
    elseif _G.MyLevel == 210 or _G.MyLevel <= 249 then

        _G.Mon = "Dangerous Prisoner"
        _G.LevelQuest = 2
        _G.NameQuest = "PrisonerQuest"
        _G.NameMon = "Dangerous Prisoner"
        _G.CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
        _G.CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
    elseif _G.MyLevel == 250 or _G.MyLevel <= 274 then

        _G.Mon = "Toga Warrior"
        _G.LevelQuest = 1
        _G.NameQuest = "ColosseumQuest"
        _G.NameMon = "Toga Warrior"
        _G.CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
        _G.CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
    elseif _G.MyLevel == 275 or _G.MyLevel <= 299 then

        _G.Mon = "Gladiator"
        _G.LevelQuest = 2
        _G.NameQuest = "ColosseumQuest"
        _G.NameMon = "Gladiator"
        _G.CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
        _G.CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
    elseif _G.MyLevel == 300 or _G.MyLevel <= 324 then

        _G.Mon = "Military Soldier"
        _G.LevelQuest = 1
        _G.NameQuest = "MagmaQuest"
        _G.NameMon = "Military Soldier"
        _G.CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
        _G.CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
    elseif _G.MyLevel == 325 or _G.MyLevel <= 374 then

        _G.Mon = "Military Spy"
        _G.LevelQuest = 2
        _G.NameQuest = "MagmaQuest"
        _G.NameMon = "Military Spy"
        _G.CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
        _G.CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
    elseif _G.MyLevel == 375 or _G.MyLevel <= 399 then

        _G.Mon = "Fishman Warrior"
        _G.LevelQuest = 1
        _G.NameQuest = "FishmanQuest"
        _G.NameMon = "Fishman Warrior"
        _G.CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
        _G.CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    elseif _G.MyLevel == 400 or _G.MyLevel <= 449 then

        _G.Mon = "Fishman Commando"
        _G.LevelQuest = 2
        _G.NameQuest = "FishmanQuest"
        _G.NameMon = "Fishman Commando"
        _G.CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
        _G.CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    elseif _G.MyLevel == 450 or _G.MyLevel <= 474 then

        _G.Mon = "God's Guard"
        _G.LevelQuest = 1
        _G.NameQuest = "SkyExp1Quest"
        _G.NameMon = "God's Guard"
        _G.CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
        _G.CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
        end
    elseif _G.MyLevel == 475 or _G.MyLevel <= 524 then

        _G.Mon = "Shanda"
        _G.LevelQuest = 2
        _G.NameQuest = "SkyExp1Quest"
        _G.NameMon = "Shanda"
        _G.CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
        _G.CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
        end
    elseif _G.MyLevel == 525 or _G.MyLevel <= 549 then

        _G.Mon = "Royal Squad"
        _G.LevelQuest = 1
        _G.NameQuest = "SkyExp2Quest"
        _G.NameMon = "Royal Squad"
        _G.CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        _G.CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
    elseif _G.MyLevel == 550 or _G.MyLevel <= 624 then

        _G.Mon = "Royal Soldier"
        _G.LevelQuest = 2
        _G.NameQuest = "SkyExp2Quest"
        _G.NameMon = "Royal Soldier"
        _G.CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        _G.CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
    elseif _G.MyLevel == 625 or _G.MyLevel <= 649 then

        _G.Mon = "Galley Pirate"
        _G.LevelQuest = 1
        _G.NameQuest = "FountainQuest"
        _G.NameMon = "Galley Pirate"
        _G.CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
        _G.CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
    elseif _G.MyLevel >= 650 then

        _G.Mon = "Galley Captain"
        _G.LevelQuest = 2
        _G.NameQuest = "FountainQuest"
        _G.NameMon = "Galley Captain"
        _G.CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
        _G.CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
    end
elseif World2 then

    if _G.MyLevel == 700 or _G.MyLevel <= 724 then

        _G.Mon = "Raider"
        _G.LevelQuest = 1
        _G.NameQuest = "Area1Quest"
        _G.NameMon = "Raider"
        _G.CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
        _G.CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
    elseif _G.MyLevel == 725 or _G.MyLevel <= 774 then

        _G.Mon = "Mercenary"
        _G.LevelQuest = 2
        _G.NameQuest = "Area1Quest"
        _G.NameMon = "Mercenary"
        _G.CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
        _G.CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
    elseif _G.MyLevel == 775 or _G.MyLevel <= 799 then

        _G.Mon = "Swan Pirate"
        _G.LevelQuest = 1
        _G.NameQuest = "Area2Quest"
        _G.NameMon = "Swan Pirate"
        _G.CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
        _G.CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
    elseif _G.MyLevel == 800 or _G.MyLevel <= 874 then

        _G.Mon = "Factory Staff"
        _G.NameQuest = "Area2Quest"
        _G.LevelQuest = 2
        _G.NameMon = "Factory Staff"
        _G.CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
        _G.CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
    elseif _G.MyLevel == 875 or _G.MyLevel <= 899 then

        _G.Mon = "Marine Lieutenant"
        _G.LevelQuest = 1
        _G.NameQuest = "MarineQuest3"
        _G.NameMon = "Marine Lieutenant"
        _G.CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
        _G.CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
    elseif _G.MyLevel == 900 or _G.MyLevel <= 949 then

        _G.Mon = "Marine Captain"
        _G.LevelQuest = 2
        _G.NameQuest = "MarineQuest3"
        _G.NameMon = "Marine Captain"
        _G.CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
        _G.CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
    elseif _G.MyLevel == 950 or _G.MyLevel <= 974 then

        _G.Mon = "Zombie"
        _G.LevelQuest = 1
        _G.NameQuest = "ZombieQuest"
        _G.NameMon = "Zombie"
        _G.CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
        _G.CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
    elseif _G.MyLevel == 975 or _G.MyLevel <= 999 then

        _G.Mon = "Vampire"
        _G.LevelQuest = 2
        _G.NameQuest = "ZombieQuest"
        _G.NameMon = "Vampire"
        _G.CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
        _G.CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
    elseif _G.MyLevel == 1000 or _G.MyLevel <= 1049 then

        _G.Mon = "Snow Trooper"
        _G.LevelQuest = 1
        _G.NameQuest = "SnowMountainQuest"
        _G.NameMon = "Snow Trooper"
        _G.CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
        _G.CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
    elseif _G.MyLevel == 1050 or _G.MyLevel <= 1099 then

        _G.Mon = "Winter Warrior"
        _G.LevelQuest = 2
        _G.NameQuest = "SnowMountainQuest"
        _G.NameMon = "Winter Warrior"
        _G.CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
        _G.CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
    elseif _G.MyLevel == 1100 or _G.MyLevel <= 1124 then

        _G.Mon = "Lab Subordinate"
        _G.LevelQuest = 1
        _G.NameQuest = "IceSideQuest"
        _G.NameMon = "Lab Subordinate"
        _G.CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
        _G.CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
    elseif _G.MyLevel == 1125 or _G.MyLevel <= 1174 then

        _G.Mon = "Horned Warrior"
        _G.LevelQuest = 2
        _G.NameQuest = "IceSideQuest"
        _G.NameMon = "Horned Warrior"
        _G.CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
        _G.CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
    elseif _G.MyLevel == 1175 or _G.MyLevel <= 1199 then

        _G.Mon = "Magma Ninja"
        _G.LevelQuest = 1
        _G.NameQuest = "FireSideQuest"
        _G.NameMon = "Magma Ninja"
        _G.CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
        _G.CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
    elseif _G.MyLevel == 1200 or _G.MyLevel <= 1249 then

        _G.Mon = "Lava Pirate"
        _G.LevelQuest = 2
        _G.NameQuest = "FireSideQuest"
        _G.NameMon = "Lava Pirate"
        _G.CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
        _G.CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
    elseif _G.MyLevel == 1250 or _G.MyLevel <= 1274 then

        _G.Mon = "Ship Deckhand"
        _G.LevelQuest = 1
        _G.NameQuest = "ShipQuest1"
        _G.NameMon = "Ship Deckhand"
        _G.CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)         
        _G.CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)    
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
        end
    elseif _G.MyLevel == 1275 or _G.MyLevel <= 1299 then

        _G.Mon = "Ship Engineer"
        _G.LevelQuest = 2
        _G.NameQuest = "ShipQuest1"
        _G.NameMon = "Ship Engineer"
        _G.CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)   
        _G.CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)   
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
        end             
    elseif _G.MyLevel == 1300 or _G.MyLevel <= 1324 then

        _G.Mon = "Ship Steward"
        _G.LevelQuest = 1
        _G.NameQuest = "ShipQuest2"
        _G.NameMon = "Ship Steward"
        _G.CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)         
        _G.CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)      
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
        end
    elseif _G.MyLevel == 1325 or _G.MyLevel <= 1349 then

        _G.Mon = "Ship Officer"
        _G.LevelQuest = 2
        _G.NameQuest = "ShipQuest2"
        _G.NameMon = "Ship Officer"
        _G.CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
        _G.CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
        end
    elseif _G.MyLevel == 1350 or _G.MyLevel <= 1374 then

        _G.Mon = "Arctic Warrior"
        _G.LevelQuest = 1
        _G.NameQuest = "FrostQuest"
        _G.NameMon = "Arctic Warrior"
        _G.CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
        _G.CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
        if _G.AutoFarm and (_G.CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422))
        end
    elseif _G.MyLevel == 1375 or _G.MyLevel <= 1424 then

        _G.Mon = "Snow Lurker"
        _G.LevelQuest = 2
        _G.NameQuest = "FrostQuest"
        _G.NameMon = "Snow Lurker"
        _G.CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
        _G.CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
    elseif _G.MyLevel == 1425 or _G.MyLevel <= 1449 then

        _G.Mon = "Sea Soldier"
        _G.LevelQuest = 1
        _G.NameQuest = "ForgottenQuest"
        _G.NameMon = "Sea Soldier"
        _G.CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
        _G.CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
    elseif _G.MyLevel >= 1450 then

        _G.Mon = "Water Fighter"
        _G.LevelQuest = 2
        _G.NameQuest = "ForgottenQuest"
        _G.NameMon = "Water Fighter"
        _G.CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
        _G.CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
    end
elseif World3 then

    if _G.MyLevel == 1500 or _G.MyLevel <= 1524 then

        _G.Mon = "Pirate Millionaire"
        _G.LevelQuest = 1
        _G.NameQuest = "PiratePortQuest"
        _G.NameMon = "Pirate Millionaire"
        _G.CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
        _G.CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
    elseif _G.MyLevel == 1525 or _G.MyLevel <= 1574 then

        _G.Mon = "Pistol Billionaire"
        _G.LevelQuest = 2
        _G.NameQuest = "PiratePortQuest"
        _G.NameMon = "Pistol Billionaire"
        _G.CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
        _G.CFrameMon = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875)
    elseif _G.MyLevel == 1575 or _G.MyLevel <= 1599 then

        _G.Mon = "Dragon Crew Warrior"
        _G.LevelQuest = 1
        _G.NameQuest = "AmazonQuest"
        _G.NameMon = "Dragon Crew Warrior"
        _G.CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
        _G.CFrameMon = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
    elseif _G.MyLevel == 1600 or _G.MyLevel <= 1624 then
 
        _G.Mon = "Dragon Crew Archer"
        _G.NameQuest = "AmazonQuest"
        _G.LevelQuest = 2
        _G.NameMon = "Dragon Crew Archer"
        _G.CFrameQuest = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
        _G.CFrameMon = CFrame.new(6616.41748046875, 441.7670593261719, 446.0469970703125)
    elseif _G.MyLevel == 1625 or _G.MyLevel <= 1649 then

        _G.Mon = "Female Islander"
        _G.NameQuest = "AmazonQuest2"
        _G.LevelQuest = 1
        _G.NameMon = "Female Islander"
        _G.CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
        _G.CFrameMon = CFrame.new(4685.25830078125, 735.8078002929688, 815.3425903320312)
    elseif _G.MyLevel == 1650 or _G.MyLevel <= 1699 then
 
        _G.Mon = "Giant Islander"
        _G.NameQuest = "AmazonQuest2"
        _G.LevelQuest = 2
        _G.NameMon = "Giant Islander"
        _G.CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
        _G.CFrameMon = CFrame.new(4729.09423828125, 590.436767578125, -36.97627639770508)
    elseif _G.MyLevel == 1700 or _G.MyLevel <= 1724 then

        _G.Mon = "Marine Commodore"
        _G.LevelQuest = 1
        _G.NameQuest = "MarineTreeIsland"
        _G.NameMon = "Marine Commodore"
        _G.CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
        _G.CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
    elseif _G.MyLevel == 1725 or _G.MyLevel <= 1774 then

        _G.Mon = "Marine Rear Admiral"
        _G.NameMon = "Marine Rear Admiral"
        _G.NameQuest = "MarineTreeIsland"
        _G.LevelQuest = 2
        _G.CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
        _G.CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
    elseif _G.MyLevel == 1775 or _G.MyLevel <= 1799 then

        _G.Mon = "Fishman Raider"
        _G.LevelQuest = 1
        _G.NameQuest = "DeepForestIsland3"
        _G.NameMon = "Fishman Raider"
        _G.CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
        _G.CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
    elseif _G.MyLevel == 1800 or _G.MyLevel <= 1824 then

        _G.Mon = "Fishman Captain"
        _G.LevelQuest = 2
        _G.NameQuest = "DeepForestIsland3"
        _G.NameMon = "Fishman Captain"
        _G.CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
        _G.CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625) 
    elseif _G.MyLevel == 1825 or _G.MyLevel <= 1849 then

        _G.Mon = "Forest Pirate"
        _G.LevelQuest = 1
        _G.NameQuest = "DeepForestIsland"
        _G.NameMon = "Forest Pirate"
        _G.CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
        _G.CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
    elseif _G.MyLevel == 1850 or _G.MyLevel <= 1899 then

        _G.Mon = "Mythological Pirate"
        _G.LevelQuest = 2
        _G.NameQuest = "DeepForestIsland"
        _G.NameMon = "Mythological Pirate"
        _G.CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)   
        _G.CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
    elseif _G.MyLevel == 1900 or _G.MyLevel <= 1924 then

        _G.Mon = "Jungle Pirate"
        _G.LevelQuest = 1
        _G.NameQuest = "DeepForestIsland2"
        _G.NameMon = "Jungle Pirate"
        _G.CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
        _G.CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
    elseif _G.MyLevel == 1925 or _G.MyLevel <= 1974 then

        _G.Mon = "Musketeer Pirate"
        _G.LevelQuest = 2
        _G.NameQuest = "DeepForestIsland2"
        _G.NameMon = "Musketeer Pirate"
        _G.CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
        _G.CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
    elseif _G.MyLevel == 1975 or _G.MyLevel <= 1999 then

        _G.Mon = "Reborn Skeleton"
        _G.LevelQuest = 1
        _G.NameQuest = "HauntedQuest1"
        _G.NameMon = "Reborn Skeleton"
        _G.CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
        _G.CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
    elseif _G.MyLevel == 2000 or _G.MyLevel <= 2024 then

        _G.Mon = "Living Zombie"
        _G.LevelQuest = 2
        _G.NameQuest = "HauntedQuest1"
        _G.NameMon = "Living Zombie"
        _G.CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
        _G.CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
    elseif _G.MyLevel == 2025 or _G.MyLevel <= 2049 then

        _G.Mon = "Demonic Soul"
        _G.LevelQuest = 1
        _G.NameQuest = "HauntedQuest2"
        _G.NameMon = "Demonic Soul"
        _G.CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0) 
        _G.CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
    elseif _G.MyLevel == 2050 or _G.MyLevel <= 2074 then

        _G.Mon = "Posessed Mummy"
        _G.LevelQuest = 2
        _G.NameQuest = "HauntedQuest2"
        _G.NameMon = "Posessed Mummy"
        _G.CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        _G.CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
    elseif _G.MyLevel == 2075 or _G.MyLevel <= 2099 then

        _G.Mon = "Peanut Scout"
        _G.LevelQuest = 1
        _G.NameQuest = "NutsIslandQuest"
        _G.NameMon = "Peanut Scout"
        _G.CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        _G.CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
    elseif _G.MyLevel == 2100 or _G.MyLevel <= 2124 then

        _G.Mon = "Peanut President"
        _G.LevelQuest = 2
        _G.NameQuest = "NutsIslandQuest"
        _G.NameMon = "Peanut President"
        _G.CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        _G.CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
    elseif _G.MyLevel == 2125 or _G.MyLevel <= 2149 then

        _G.Mon = "Ice Cream Chef"
        _G.LevelQuest = 1
        _G.NameQuest = "IceCreamIslandQuest"
        _G.NameMon = "Ice Cream Chef"
        _G.CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        _G.CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
    elseif _G.MyLevel == 2150 or _G.MyLevel <= 2199 then

        _G.Mon = "Ice Cream Commander"
        _G.LevelQuest = 2
        _G.NameQuest = "IceCreamIslandQuest"
        _G.NameMon = "Ice Cream Commander"
        _G.CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        _G.CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
    elseif _G.MyLevel == 2200 or _G.MyLevel <= 2224 then

        _G.Mon = "Cookie Crafter"
        _G.LevelQuest = 1
        _G.NameQuest = "CakeQuest1"
        _G.NameMon = "Cookie Crafter"
        _G.CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
        _G.CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
    elseif _G.MyLevel == 2225 or _G.MyLevel <= 2249 then

        _G.Mon = "Cake Guard"
        _G.LevelQuest = 2
        _G.NameQuest = "CakeQuest1"
        _G.NameMon = "Cake Guard"
        _G.CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
        _G.CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
    elseif _G.MyLevel == 2250 or _G.MyLevel <= 2274 then

        _G.Mon = "Baking Staff"
        _G.LevelQuest = 1
        _G.NameQuest = "CakeQuest2"
        _G.NameMon = "Baking Staff"
        _G.CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
        _G.CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
    elseif _G.MyLevel == 2275 or _G.MyLevel <= 2299 then

        _G.Mon = "Head Baker"
        _G.LevelQuest = 2
        _G.NameQuest = "CakeQuest2"
        _G.NameMon = "Head Baker"
        _G.CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
        _G.CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
    elseif _G.MyLevel == 2300 or _G.MyLevel <= 2324 then

        _G.Mon = "Cocoa Warrior"
        _G.LevelQuest = 1
        _G.NameQuest = "ChocQuest1"
        _G.NameMon = "Cocoa Warrior"
        _G.CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
        _G.CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
    elseif _G.MyLevel == 2325 or _G.MyLevel <= 2349 then

        _G.Mon = "Chocolate Bar Battler"
        _G.LevelQuest = 2
        _G.NameQuest = "ChocQuest1"
        _G.NameMon = "Chocolate Bar Battler"
        _G.CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
        _G.CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
    elseif _G.MyLevel == 2350 or _G.MyLevel <= 2374 then

        _G.Mon = "Sweet Thief"
        _G.LevelQuest = 1
        _G.NameQuest = "ChocQuest2"
        _G.NameMon = "Sweet Thief"
        _G.CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
        _G.CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
    elseif _G.MyLevel == 2375 or _G.MyLevel <= 2399 then

        _G.Mon = "Candy Rebel"
        _G.LevelQuest = 2
        _G.NameQuest = "ChocQuest2"
        _G.NameMon = "Candy Rebel"
        _G.CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
        _G.CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
    elseif _G.MyLevel == 2400 or _G.MyLevel <= 2424 then

        _G.Mon = "Candy Pirate"
        _G.LevelQuest = 1
        _G.NameQuest = "CandyQuest1"
        _G.NameMon = "Candy Pirate"
        _G.CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
        _G.CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
    elseif _G.MyLevel == 2425 or _G.MyLevel <= 2449 then

        _G.Mon = "Snow Demon"
        _G.LevelQuest = 2
        _G.NameQuest = "CandyQuest1"
        _G.NameMon = "Snow Demon"
        _G.CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
        _G.CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
    elseif _G.MyLevel == 2450 or _G.MyLevel <= 2474 then

        _G.Mon = "Isle Outlaw"
        _G.LevelQuest = 1
        _G.NameQuest = "TikiQuest1"
        _G.NameMon = "Isle Outlaw"
        _G.CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
        _G.CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
    elseif _G.MyLevel == 2475 or _G.MyLevel <= 2499 then

        _G.Mon = "Island Boy"
        _G.LevelQuest = 2
        _G.NameQuest = "TikiQuest1"
        _G.NameMon = "Island Boy"
        _G.CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
        _G.CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562)
    elseif _G.MyLevel == 2500 or _G.MyLevel <= 2524 then

        _G.Mon = "Sun-kissed Warrior"
        _G.LevelQuest = 1
        _G.NameQuest = "TikiQuest2"
        _G.NameMon = "kissed"
        _G.CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
        _G.CFrameMon = CFrame.new(-16349.8779296875, 92.0808334350586, 1123.4169921875)
    elseif _G.MyLevel == 2525 or _G.MyLevel <= 2550 then

        _G.Mon = "Isle Champion"
        _G.LevelQuest = 2
        _G.NameQuest = "TikiQuest2"
        _G.NameMon = "Isle Champion"
        _G.CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
        _G.CFrameMon = CFrame.new(-16347.4150390625, 92.09503936767578, 1122.335205078125)
    elseif _G.MyLevel == 2550 or _G.MyLevel <= 2575 then

        _G.Mon = "Serpent Hunter"
        _G.LevelQuest = 1
        _G.NameQuest = "TikiQuest3"
        _G.NameMon = "Serpent Hunter"
        _G.CFrameQuest = CFrame.new(-16665.2, 104.596, 1579.69)
        _G.CFrameMon = CFrame.new(-16602.8, 156.831, 1528.83)
    elseif _G.MyLevel == 2575 or _G.MyLevel <= 2650 then

        _G.Mon = "Skull Slayer"
        _G.LevelQuest = 2
        _G.NameQuest = "TikiQuest3"
        _G.NameMon = "Skull Slayer"
        _G.CFrameQuest = CFrame.new(-16665.2, 104.596, 1579.69)
        _G.CFrameMon = CFrame.new(-16846.7, 152.811, 1644.17)
    end
end
