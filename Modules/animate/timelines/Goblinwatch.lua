local timeline = Animate.Timeline:new()

timeline:set(Animate.Camera, {X = -17762, Y = -14377, Z = 1600, Yaw = 1336})
timeline:to(Animate.Camera, {X = -18868, Y = -14448, Z = 1600, Yaw = 1740, duration = 5.2})
timeline:to(Animate.Camera, {X = -19102, Y = -14943, Z = 2136, Yaw = 1968, Pitch = 64, duration = 12.2})
timeline:to(Animate.Camera, {X = -19078, Y = -15007, Z = 1984, Yaw = 1520, Pitch = -64, duration = 1.2}, 13.2)
timeline:to(Animate.Camera, {X = -18986, Y = -15611, Z = 1985, Yaw = 2047, Pitch = 0, duration = 10.2})
timeline:to(Animate.Camera, {OutdoorFOV = 60, duration = 3})
timeline:to(Animate.Camera, {X = -19050, Y = -15406, Z = 1984, Yaw = 2036, duration = 12.2})
timeline:to(Animate.Camera, {OutdoorFOV = 170, duration = 3})
timeline:to(Animate.Camera, {X = -18507, Y = -15414, Z = 1984, Yaw = 1928, duration = 10.2})

return timeline