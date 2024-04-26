
---Create a window with a button that jumps around when clicked.
function jumpyButtonWindow()
    --Create a new window.
    local UI = context.UI
    local window = UI.createWindow("Window")
    window:setSize({width = 500, height = 500})

    --Add a button to the window.
    local jumpyButton = UI.Button()
    jumpyButton:setText("Jump")
    window:addChild(jumpyButton)
    jumpyButton:setWidth(50)

    --Add a callback to the button that moves it to a random position within the window when clicked.
    jumpyButton.onClick = function(self)
      local windowSize = window:getSize()
      local windowPosition = window:getPosition()
      local buttonSize = jumpyButton:getSize()
      local buttonPosition = jumpyButton:getPosition()
      --Keeping a small margin to avoid the button being placed outside the window or very close to the edges.
      buttonPosition.x = getRandomNumber(windowPosition.x + buttonSize.width, windowSize.width - buttonSize.width * 2)
      buttonPosition.y = getRandomNumber(windowPosition.y + buttonSize.height, windowSize.height - buttonSize.height * 2)
      jumpyButton:setPosition(buttonPosition)
    end
  end