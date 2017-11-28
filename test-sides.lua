local component = require("component")

devices = {}

i = 0

for k,v in component.list() do
  if v == "ElnProbe" then
    print("Found a probe: " .. k)
    devices[i] = k
    i = i + 1
  end
end

for k,v in pairs(devices) do
  print(k,v)
end

print("Select a device from the list above")

selected = ""

while true do
  choice = io.read()
  for k,v in pairs(devices) do
    if tonumber(choice) == tonumber(k) then
      selected = v
    end
  end
  if selected ~= "" then
    break
  else
    print("Please make a selection")
  end
end

print("You selected device " .. selected)

device = component.proxy(component.get(selected))

print("Beginning scan for connected cables on selected device")

SIDES = {}
SIDES["XN"] = "West (x-)"
SIDES["XP"] = "East (x+)"
SIDES["YN"] = "Bottom"
SIDES["YP"] = "Top"
SIDES["ZN"] = "North (z-)"
SIDES["ZP"] = "South (z+)"

for k,v in pairs(SIDES) do
  if device.signalGetIn(k) > 0 then
    print("It appears that the " .. v .. " side of the block has a voltage of " .. device.signalGetIn(k) * 50 .. "v.")
  else
    print("It appears that the ".. v .. " side is not connected.")
  end
end
