Boss = {}

Boss.new = function()
  local self = {}

  self.image = love.graphics.newImage("enemy.png")
  self.imageLeft = love.graphics.newImage("enemyLeft.png")
  self.imageRight = love.graphics.newImage("enemyRight.png")

  self.currentImage = self.image

  self.x = 0
  self.y = WH - self.currentImage:getHeight()

  self.xv = 100

  self.draw = function()
    love.graphics.draw(self.currentImage, self.x, self.y)
  end

  self.update = function(dt)
    if player.x > self.x then
      self.x = self.x + self.xv * dt
      self.currentImage = self.imageRight
    else
      self.x = self.x - self.xv * dt
      self.currentImage = self.imageLeft
    end
    if player.x + player.currentImage:getWidth() > self.x and player.x < self.x + self.currentImage:getWidth() and player.y + player.currentImage:getHeight() > self.y then
      playing = false
    end
  end

  return self
end
