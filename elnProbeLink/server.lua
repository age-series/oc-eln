component = require("component")

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

sn = {}
sn[1] = "XN"
sn[2] = "XP"
sn[3] = "YN"
sn[4] = "YP"
sn[5] = "ZN"
sn[6] = "ZP"

while 1 do
  message = ""
  for k,v in pairs(sn) do
    message = message .. tostring(probe.signalGetIn(v) .. ",")
  end

  message = message:sub(1, -2)
  link.send(message)

end
