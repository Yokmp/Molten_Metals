
function assembler1pipepictures(tint)
  tint = tint or { r = 1, g = 1, b = 1, a = 1 }
  return
  {
    north =
    {
      filename = "__Molten_Metals__/graphics/assembling-machine-1/hr-assembling-machine-1-pipe-N.png",
      priority = "extra-high",
      width = 71,
      height = 38,
      shift = util.by_pixel(2.25, 13.5),
      scale = 0.5,
      tint = tint
    },
    east =
    {
      filename = "__Molten_Metals__/graphics/assembling-machine-1/hr-assembling-machine-1-pipe-E.png",
      priority = "extra-high",
      width = 42,
      height = 76,
      shift = util.by_pixel(-24.5, 1),
      scale = 0.5,
      tint = tint
    },
    south =
    {
      filename = "__Molten_Metals__/graphics/assembling-machine-1/hr-assembling-machine-1-pipe-S.png",
      priority = "extra-high",
      width = 88,
      height = 61,
      shift = util.by_pixel(0, -31.25),
      scale = 0.5,
      tint = tint
  },
    west =
    {
      filename = "__Molten_Metals__/graphics/assembling-machine-1/hr-assembling-machine-1-pipe-W.png",
      priority = "extra-high",
      width = 39,
      height = 73,
      shift = util.by_pixel(25.75, 1.25),
      scale = 0.5,
      tint = tint
    }
  }
end