component = require("component")

tunnels = {}
probes = {}

for k,v in pairs(devices) do
  print(k,v)
end

i = 0
j = 0

for k,v in component.list() do
  if v == "tunnel" then
    print("Found a tunnel: " .. k)
    tunnels[i] = k
    i = i + 1
  end
  if v == "ElnProbe" then
    print("Found a Eln Probe: " .. k)
    probes[j] = k
    j = j + 1
  end
end

link = component.proxy(component.get(tunnels[0]))
probe = component.proxy(component.get(probes[0]))

SIDES = {}
SIDES["XN"] = "West (x-)"
SIDES["XP"] = "East (x+)"
SIDES["YN"] = "Bottom"
SIDES["YP"] = "Top"
SIDES["ZN"] = "North (z-)"
SIDES["ZP"] = "South (z+)"

while 1 do
  _, _, _, _, _, message = event.pull("modem_message")
  print(message)

  a,b,c,d,e,f = message:match("([^,]+),([^,]+)")

  for k,v in pairs(SIDES) do
    print(k)
  end
end
