component = require("component")
event = require("event")

tunnels = {}
probes = {}

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

for k,v in pairs(SIDES) do
  probe.signalSetDir(k,"out")
end

while 1 do
  _, _, _, _, _, message = event.pull("modem_message")
  print(message)

  a,b,c,d,e,f = message:match("([^,]+),([^,]+)")

  probe.signalSetOut(SIDES[0], tonumber(a))
  probe.signalSetOut(SIDES[1], tonumber(b))
  probe.signalSetOut(SIDES[2], tonumber(c))
  probe.signalSetOut(SIDES[3], tonumber(d))
  probe.signalSetOut(SIDES[4], tonumber(e))
  probe.signalSetOut(SIDES[5], tonumber(f))
  os.sleep(0.05)
end
