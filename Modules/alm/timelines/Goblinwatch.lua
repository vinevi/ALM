local timeline = Animate.Timeline:new()

timeline:set(Animate.Camera, {X = -9814, Y = -6515, Z = 161, Yaw = 1592, Pitch = 0})
timeline:to(Animate.Camera, {X = -9814, Y = -6515, Z = 161, Yaw = 1592, Pitch = 0, duration = 1})
timeline:to(Animate.Camera, {X = -9625, Y = -6633, Z = 577, Yaw = 1808, Pitch = 0, duration = 5})
timeline:to(Animate.Camera, {X = -14020, Y = -10172, Z = 883, Yaw = 1048, Pitch = -50, duration = 8})
timeline:to(Animate.Camera, {X = -18829, Y = -10431, Z = 22, Yaw = 1288, Pitch = 0, duration = 8})
timeline:to(Animate.Camera, {X = -18829, Y = -10431, Z = 22, Yaw = 812, Pitch = 0, duration = 3})
timeline:to(Animate.Camera, {X = -18253, Y = -4038, Z = 501, Yaw = 480, Pitch = 0, duration = 8})
timeline:to(Animate.Camera, {X = -20618, Y = -1245, Z = 160, Yaw = 968, Pitch = 0, duration = 5})

return timeline