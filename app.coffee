items = [
  "All Deals",
  "New Deals",
  "Food & Drink",
  "Events & Activities",
  "Beauty & Spas",
  "Health & Fitness",
  "Home & Garden",
  "Automotive",
  "Shopping"
]

firstNavItem = null

itemContainer = new View
  width: 640
  clip: false

# ANIMATE ON LOAD

items.map (item, index) ->

  itemView = new View
    superView: itemContainer
    width: 640
    height: 88
    x: 0
    y: 1000 + index * 88
    opacity: 0
    clip: false
    class: 'framer list'
  
  firstNavItem = itemView if index is 0
  
  itemView.style =
    borderBottom: "1px solid rgba(0,0,0,.2)"
    lineHeight: "#{itemView.height}px"
    paddingLeft: "20px"
    cursor: "pointer"
    backgroundColor: "#f0f0f0"

  if index > 1
    itemView.html = "#{item} <span></span>"
  else
    itemView.html = "#{item}"
  
  utils.delay index * 30, ->
    itemView.animate
      properties:
        y: 216 + index * 88
        opacity: 1
      curve: "spring(500,30,800)"
  
  # LOAD SUB ITEMS
  
  itemView.on Events.TouchStart, () ->
    
    # IF NOT FIRST TWO ITEMS IN LIST
    
    if index > 0 && itemView.y != 216
      originalPosition = itemView.y

      moveTop = new Animation
        view: itemView
        properties:
          y: 216
        curve: "ease-out"
        time: 300
      
      itemView.html = "#{item} <span class='close'></span>"
  
      moveTop.start()
      utils.delay(100,showSub)

      # MANUAL REVERSE
      
      itemView.on Events.TouchStart, (event) ->
        itemView.html = "#{item} <span></span>"
        moveBack = new Animation
          view: itemView
          properties:
            y: originalPosition
          curve: "ease-out"
          time: 300

        moveBack.start()
        hideSub()

# SUB ITEMS

subItems = [
  "Sub Cat One (32)",
  "Sub Cat Two (14)",
  "Sub Cat Three (21)",
  "Sub Cat Four (11)",
  "Sub Cat Five (23)",
  "Sub Cat Six (5)",
  "Sub Cat Seven (14)",
  "Sub Cat Eight (24)",
]

subItemContainer = new View
  properties:
    y: 1136
  clip: false
  
hideSub = () ->
  subItemContainer.animate
    properties:
      opacity: 0
    curve: "ease-out"
    time: 300
  subItemContainer.destroy()

showSub = () ->
  subItemContainer = new View
    properties:
      y: 1136
      width: 640
    clip: false
    style:
      backgroundColor: "#fafafa"
    
  subItems.map (item, index) ->
  
    subItemView = new View
      superView: subItemContainer
      width: 640
      height: 88
      x: 640
      y: 304 + index * 88
      opacity: 0
      clip: true
      class: 'framer list'
    
    subItemView.style =
      borderBottom: "1px solid rgba(0,0,0,.2)"
      lineHeight: "#{subItemView.height}px"
      color: "#75787b"
      paddingLeft: "40px"
      cursor: "pointer"
      backgroundColor: "#fafafa"

    subItemView.html = "#{item}"

    utils.delay index * 30, ->
      subItemView.animate
        properties:
          x: 0
          opacity: 1
        curve: "spring(400,30,800)"
        
    
    subItemView.on Events.TouchStart, () ->
      alert "Load Sub-Category"