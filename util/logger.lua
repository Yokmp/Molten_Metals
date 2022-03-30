

  -- silent   = 0
  -- info     = 1
  -- warning  = 2
  -- error    = 3

log_level = log_level or 2
local function logger(level, message, description)
  description = type(description) == "string" and description or "nil"
  if not type(level) == "number" and not level == 0 then
    if level == 1 and log_level == 1 then
      log(serpent.block(message))
    end
    if level == 2 and log_level == 2  then
      log(serpent.block(message).." - "..description)
    end
    if level == 3 and log_level >= 3  then
      log(serpent.block(message))
      error(description)
    end
  end
end
function info(message)
  logger(1, message)
end
function warn(message, description)
  logger(2, message, description)
end
function err(message, description)
  logger(3, message, description)
end