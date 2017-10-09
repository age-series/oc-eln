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
