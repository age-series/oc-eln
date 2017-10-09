local component = require("component")

devices = {}

i = 0

for k,v in component.list() do
  print(k,v)
  if v == "ElnProbe" then
    print(k)
    devices[i] = k
    i = i + 1
  end
end

for k,v in devices.list() do
  print(k,v)
end
