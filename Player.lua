Player = {}

Player.new = function()
  local self = {}

  self.x = 500
  self.y = 100

  self.xv = 600
  self.yv = 0
  self.acceleration = 6

  self.canJump = false

  self.imageFront = love.graphics.newImage("player.png")
  self.imageLeft = love.graphics.newImage("playerLeft.png")
  self.imageRight = love.graphics.newImage("playerRight.png")

  self.currentImage = self.imageFront

  self.draw = function()
    love.graphics.draw(self.currentImage, self.x, self.y)
  end

  self.update = function(dt)
    self.y = self.y + self.yv * dt
    self.yv = self.yv + self.acceleration
    if self.y + self.currentImage:getHeight() + self.yv * dt > WH then
      self.y = WH - self.currentImage:getHeight()
      self.yv = 0
      self.acceleration = 0
      self.canJump = true
    end
    if love.keyboard.isDown("a") and self.x - self.xv * dt > 0 then
      self.x = self.x - self.xv * dt
      self.currentImage = self.imageLeft
    end
    if love.keyboard.isDown("d") and self.x + self.currentImage:getWidth() + self.xv * dt < WW then
      self.x = self.x + self.xv * dt
      self.currentImage = self.imageRight
    end
    if not (love.keyboard.isDown("a")) and not (love.keyboard.isDown("d")) then
      self.currentImage = self.imageFront
    end
  end

  self.jump = function()
    if self.canJump then
      self.yv = - 600
      self.acceleration = 6
      self.canJump = false
      boss.xv = boss.xv * 1.1
    end
  end

  return self
end
