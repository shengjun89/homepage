# This imports all the layers for "NEW homepage for framer" into newHomepageForFramerLayers2
homePage = Framer.Importer.load "imported/NEW homepage for framer"

Utils.globalLayers(homePage)

bg = new BackgroundLayer
	backgroundColor: "#EDEDEE"
banner.visible = false
TOP.style.boxShadow = "0 1px 0px rgba(0,0,0,0.2)"
arrow_copy.opacity = 0
text = new Layer
	html: "<span style='font-size:28px;padding:32px;padding-right:58px;line-height:1.4;'>您有3张新福利</span>"	
	x: 400
	y: 360
	width: 340
	height: 40
	opacity: .8
	backgroundColor: "rgba(0,0,0,0.2)"
	borderRadius: 20
	borderColor: "#FFF"
	z: 2
# 	superLayer: content
 arrow.superLayer = text
 arrow.z = 2
 arrow.y = 360
 arrow.rotation = 0
page = new PageComponent
 	width:Screen.width,height:346
 	y:128, scrollVertical: false,backgroundColor: "#CCC"
 	
 allIndicators = []
 banners = []
 amount = 4
 
scroll = ScrollComponent.wrap(content)
scroll.scrollHorizontal = false
scroll.speedY = 0.6
scroll.y = 32
scroll.height = 1196
# content.backgroundColor = "#EDEDEE"
scroll.contentInset = {top: 400}
content.centerX()
content.width = 750




# Generate card layers
for i in [0...amount]
	ban = new Layer 
		backgroundColor: "#000"
		width: page.width, height: 346,opacity: 1 
		x: page.width * i, superLayer: page.content
	
# 	indicator = new Layer 
# 		backgroundColor: "#FFF"
# 		width: 12, height: 12
# 		x: 28 * i+16, y: 390
# 		borderRadius: "50%", opacity: 0.2
		
	# Stay centered regardless of the amount of cards
# 	indicator.x += (Screen.width / 2) - (12 * amount)
	
	# States
# 	indicator.states.add(active: {opacity: 1, scale:1.2})
# 	indicator.states.animationOptions = time: 0.5
	
	# Store indicators in our array
# 	allIndicators.push(indicator)
	banners.push(ban)
	allIndicators.parent = page
	
page.sendToBack()
page.placeBefore(bg)
page.rotationX = 0
page.originY = 0
text.bringToFront()


# Set indicator for current page
current = page.horizontalPageIndex(page.currentPage)
page.animationOptions = curve: "spring(200,22,0)"
# Update indicators
page.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	current = page.horizontalPageIndex(page.currentPage)
	allIndicators[current].states.switch("active")	
banners[0].image = "images/banner2.png"



#my invest
# investList = new ScrollComponent
# 	wrap: myInvest
# investList.scrollVertical = false
# investList.directionLock = true
myInvest.draggable.enabled =true
myInvest.draggable.vertical = false
myInvest.draggable.directionLock = true
myInvest.draggable.constraints = 
	x:6
	y:myInvest.y
	width:myInvest.width-2
	height:myInvest.height
	background: "#FFF"
# myInvest.draggable.directionLockThreshold = { x: 10, y: 0 }	
my.clip = true


Donebg = new Layer
	x:560
	y:68
	width:158
	height:myInvest.height-4
	superLayer: my
	backgroundColor: "#1CC89D"
	
Donebg.sendToBack()
invstBg.sendToBack()

originalPosition = my.y
scroll.draggable.enabled = false
scroll.scrollVertical = true


#Update position of Done
myInvest.on Events.DragStart, ->
	scroll.scrollVertical = false
# 	UpdateActions(this)
# 	DoneBg.animateStop()
	
myInvest.on Events.DragMove, ->
	AnimateActionsIcons(this)
# 	LeftDragActions(this)
	
myInvest.on Events.DragEnd, ->
	scroll.scrollVertical = true
	
	if Math.abs(this.x) > 200
		RemoveMyInvest(this)		

# UpdateActions = (myInvest) ->
# 	Done.y = originalPosition + myInvest.y - 84
# 	check.visible = true
# 	Donebg.height = myInvest.height - 4

#对勾动画设定
AnimateActionsIcons = (myInvest) ->
	check.opacity = 
	check.scale =
	Utils.modulate(myInvest.x, [-100, -200], [0,1], true)
	Donebg.width =
	Utils.modulate(myInvest.x, [0, -120], [72,720], true)
	Donebg.x =
	Utils.modulate(myInvest.x, [0, -40], [320,4], true)
#移除我的投资
RemoveMyInvest = (myInvest) ->
	myInvest.animate
		properties:
			x:-750
		time: 0.12	
	check.scale = 0
	Donebg.animate
		properties:
			width:750
			x:0
		time: 0.12
		
	Utils.delay 0.12, ->		
		Donebg.height = 0
		time: 0.02		
		
	my.animate
		properties:
			height:0
			opacity:0
	time: 0.02	
	
	Utils.delay 0.01, ->
		tu.animate
			properties:
				y: tu.y - 240
		time: 0.02
	
	Utils.delay 0.04, ->		
		hd.animate
			properties:
				y: hd.y - 240
		time: 0.02
	
	Utils.delay 0.12, ->		
		dj.animate
			properties:
				y: dj.y - 240
		time: 0.02
	
	Utils.delay 0.2, ->		
		ts.animate
			properties:
				y: ts.y - 240
		time: 0.02	
						
	Utils.delay 0.28, ->		
		tz.animate
			properties:
				y: tz.y - 240
		time: 0.02						
	
	scroll.contentInset = {top: 400}	
	
scroll.on Events.Move, ->
 	scrolltoY(scroll.scrollY)
scrolltoY = (y) ->				
# 	page.rotationX = Utils.modulate(y,[0,280],[0,90],true)
	page.y = Utils.modulate(y,[0,280],[128,-40],true)
	page.opacity = Utils.modulate(y,[0,160],[1,0],true)
	banners.scale = Utils.modulate(y,[0,-120],[1,1.08],true)
	text.width = Utils.modulate(y,[0,80],[300,38],true)
	text.x = Utils.modulate(y,[0,80],[420,681],true)
	arrow.rotation = Utils.modulate(y,[80,100],[0,90],true)
	text.opacity = Utils.modulate(y,[120,220],[1,0],true)
# 	arrow.opacity = Utils.modulate(y,[120,200],[1,0],false)	arrow_copy.opacity = Utils.modulate(y,[240,280],[0,1],false)

content.on Events.TouchStart, ->
	print "content"
page.on Events.TouchStart, ->
	print "page"	