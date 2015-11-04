items = [
  "All Deals",
  "New Deals",
  "Most Popular",
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
  
  itemView.html = "#{item}"
  
  utils.delay index * 30, ->
    itemView.animate
      properties:
        y: 216 + index * 88
        opacity: 1
      curve: "spring(500,30,800)"
  
  # LOAD SUB ITEMS
  
  itemView.on Events.TouchStart, () ->

    hideTop = new Animation
      view: firstNavItem
      properties:
        opacity: 0
      curve: "ease-in"
      time: 100
    
    hideTop.start()

    moveTop = new Animation
      view: itemView
      properties:
        y: 216
      curve: "ease-out"
      time: 300
    
    moveTop.start()
    
    utils.delay(100,showSub)

    
    # MANUAL REVERSE 
    
    itemView.on Events.TouchStart, (event) ->
      
      firstNavItem.animate
        properties:
          opacity: 1
        curve: "ease-in"
        time: 100

      itemView.animate
        properties:
          y: 216
        curve: "ease-out"
        time: 300
        
      subItemContainer.animate
        properties:
          opacity: 0
        curve: "ease-out"
        time: 300
        
      event.stopPropagation()


# SUB ITEMS

subItems = [
  "Italian (32)",
  "Japanese (14)",
  "Mexican (21)",
  "Sushi (11)",
  "Pizza (23)",
  "French (5)",
  "Indian (14)",
  "BBQ (4)",
  "Thai (15)",
  "Seafood (2)"
]

subItemContainer = new View
  width: 640
  clip: false
  
showSub = () ->
  subItemContainer.opacity = 1
  subItems.map (item, index) ->
  
    subItemView = new View
      superView: subItemContainer
      width: 640
      height: 88
      x: 0
      y: 1000 + index * 88
      opacity: 0
      clip: false
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
          y: 304 + index * 88
          opacity: 1
        curve: "spring(500,30,800)"