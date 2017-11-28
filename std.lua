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

device = component.proxy(component.get(devices[0]))

print("Beginning scan...")

SIDES = {}
SIDES["XN"] = "West (x-)"
SIDES["XP"] = "East (x+)"
SIDES["YN"] = "Bottom"
SIDES["YP"] = "Top"
SIDES["ZN"] = "North (z-)"
SIDES["ZP"] = "South (z+)"

--[[

0: zp
1: zn
2: xp
3: yp
4: xn
5: yn

]]--

error = 0

if device.signalGetIn("ZP") <= 0.78 and device.signalGetIn("ZP") >= 0.74 then
  print("[PASS] ZP")
else
  error = error + 1
  print("Error on side zp, expected ~0.76 and got " .. device.signalGetIn("ZP"))
end

if device.signalGetIn("ZN") <= 0.26 and device.signalGetIn("ZN") >= 0.22 then
  print("[PASS] ZN")
else
  error = error + 1
  print("Error on side zn, expected ~0.24 and got " .. device.signalGetIn("ZN"))
end

if device.signalGetIn("XP") >= 0.98 then
  print("[PASS] XP")
else
  error = error + 1
  print("Error on side xp, expected ~1.0 and got " .. device.signalGetIn("XP"))
end

if device.signalGetIn("XN") <= 0.52 and device.signalGetIn("XN") >= 0.48 then
  print("[PASS] XN")
else
  error = error + 1
  print("Error on side xn, expected ~0.5 and got " .. device.signalGetIn("XN"))
end

if error == 0 then
  print("[PASS] There were no errors.")
else
  print("[FAIL] There were errors above")
end

print("And debug statements because can")

for k,v in pairs(SIDES) do
  if device.signalGetIn(k) > 0 then
    print("It appears that the " .. v .. " side of the block has a voltage of " .. device.signalGetIn(k) * 50 .. "v.")
  end
end
