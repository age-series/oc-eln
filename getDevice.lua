local component = require("component")

t = {}

for k,v in component.list() do
  print(k,v)
  if v == "ElnProbe" then
    print(k)
    t[0] = k
  end
end

for k,v in t do
  print(k,v)
end
