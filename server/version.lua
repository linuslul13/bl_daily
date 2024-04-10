-- Citizen.CreateThread( function()
--     resourceName = GetCurrentResourceName()

--     function checkVersion(err,responseText, headers)
--         local currentVersion = GetResourceMetadata(resourceName, 'version', 0)

--         if currentVersion then
--             currentVersion = currentVersion:match('%d+%.%d+%.%d+')
--         end
--         responseText = responseText:gsub("%s", "")

--         if currentVersion == responseText then
--             print("^2" .. resourceName .. " is up to date, have fun!^0")
--         else
--             print("^3" .. resourceName .. " is outdated. \n^3Current version is ^1v" .. currentVersion .. "\n^3Available version is ^2v" .. responseText .. "\n^3Update script on github...^0")
--         end
--     end

--     PerformHttpRequest("https://raw.githubusercontent.com/isgrandson/version_check/master/pilot-job.txt", checkVersion, "GET")
-- end)

local currentVersion = "1.0.0"

PerformHttpRequest("https://api.github.com/repos/Linuslul13/dein-repository/releases/latest", function(err, text, headers)
    if err == 200 then
        local latestRelease = json.decode(text)
        local latestVersion = latestRelease.tag_name 
        local comparison = compareVersions(currentVersion, latestVersion)
        
        if comparison < 0 then
            print("^3" .. resourceName .. " is outdated. \n^3Current version is ^1v" .. currentVersion .. "\n^3Available version is ^2v" .. responseText .. "\n^3Update script on github...^0")
            print("Es ist eine neuere Version verfügbar: " .. latestVersion)
        else
            print("^2" .. resourceName .. " is up to date, have fun!^0 | ".. currentVersion)
        end
    else
        print("Fehler beim Abrufen der neuesten Version")
    end
end, "GET", "", {["Content-Type"] = 'application/json'})
