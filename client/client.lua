local playerJob = nil
local playerJobGrade = nil
ESX = exports["es_extended"]:getSharedObject()
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    while true do
      Wait(1200)
      playerJob = ESX.GetPlayerData().job.name
      playerJobGrade = ESX.GetPlayerData().job.grade
    end
    end
end)

for job,_ in pairs(wx.Jobs) do
Citizen.CreateThread(function () -- Get employee list
  ESX.TriggerServerCallback("esx_society:getEmployees", function(employees)
    local e = {}
      for k,v in pairs(employees) do
        -- print(json.encode(employees))
        local name = employees[k].name
        local grade = employees[k].job.grade_label
        local gradenumber = employees[k].job.grade
        local identifier = employees[k].identifier
        lib.registerContext({
          id = 'employees_'..job,
          title = "Employee List - ".._.Label,
          options = {
            {
              title = "Go Back",
              icon = 'chevron-left',
              menu = 'bossmenu_'..job,
              arrow = false,
            },
            {
              title = ("%s - %s"):format(name,grade),
              icon = 'user',
              onSelect = function ()
                local alert = lib.alertDialog({
                  header = '**Employee Info**',
                  content = ('**Full Name**: %s  \n **Grade**: [**%s**] %s'):format(name,gradenumber,grade),
                  centered = true,
                  cancel = true,
                  labels = {confirm="< Go Back",cancel='Copy Identifier'}
                })
                if alert == 'confirm' then
                  lib.showContext('employees_'..job)
                elseif alert == 'cancel' then
                  lib.setClipboard(identifier)
                  lib.showContext('employees_'..job)
                  lib.notify({
                    title = "Player's identifier was copied to your clipboard!",
                    type = 'success'
                })
                end
              end
            }
          }
        })
      end
  end, job)
end)
end

Citizen.SetTimeout(5000,function () -- Wait for player data retrieve
    for k,v in pairs(wx.Jobs) do
      lib.registerContext({
        id = 'bossmenu_'..k,
        title = v.Label,
        icon = v.Icon,
        options = {          {
          title = "Hire Employee",
          icon = "user-plus",
          disabled = not v.Permissions[playerJobGrade].CanHire,
          onSelect = function ()
            local hire = lib.inputDialog('Hire Employee', {
              {type = 'number', label = 'ID', description = 'ID of the player you want to hire', icon = 'user'},
            })
            TriggerServerEvent('wx_bossmenu:hireEmployee',k,hire[1])
          end
        },
        {
          title = "Kick Employee",
          icon = "user-xmark",
          disabled = not v.Permissions[playerJobGrade].CanKick,
          onSelect = function ()
            local kick = lib.inputDialog('Kick Employee', {
              {type = 'number', label = 'ID', description = 'ID of the player you want to kick', icon = 'user'},
            })
            TriggerServerEvent('wx_bossmenu:kickEmployee',k,kick[1])
          end
        },
        {
          title = "Promote Employee",
          icon = "user-gear",
          disabled = not v.Permissions[playerJobGrade].CanPromote,
          onSelect = function ()
            local promote = lib.inputDialog('Promote Employee', {
              {type = 'number', label = 'ID', description = 'ID of the player you want to promote', icon = 'user'},
            })
            TriggerServerEvent('wx_bossmenu:promoteEmployee',k,promote[1])
          end
        },
        {
          title = "Demote Employee",
          icon = "user-minus",
          disabled = not v.Permissions[playerJobGrade].CanDemote,
          onSelect = function ()
            local demote = lib.inputDialog('Demote Employee', {
              {type = 'number', label = 'ID', description = 'ID of the player you want to demote', icon = 'user'},
            })
            TriggerServerEvent('wx_bossmenu:demoteEmployee',k,demote[1])
          end
        },
        {
          title = "List of Employees",
          icon = "list-ol",
          disabled = not v.Permissions[playerJobGrade].CanOpen,
          menu = "employees_"..k
        },
      }
      })
      exports.ox_target:addSphereZone({
        coords = vec3(v.Location.x, v.Location.y, v.Location.z),
        radius = 1.0,
        options = {
            {
                name = 'wx_bossmenu:main',
                onSelect = function ()
                    lib.showContext('bossmenu_'..k)
                end,
                canInteract = function ()
                    if k == playerJob then
                      if v.Permissions[playerJobGrade].CanOpen then
                        return true
                      end
                    end
                    return false
                end,
                distance = 2.0,
                icon = 'fa-solid fa-'..v.Icon,
                label = ("Open %s Bossmenu"):format(v.Label),
            },
          }
        })
    end
end)