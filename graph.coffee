width = 500
height = 500

data =
	links: [{"source":4,"target":0, 'type': 'father'}
			{"source":3,"target":0, 'type': 'mother'}
			{"source":4,"target":1, 'type': 'father'}
			{"source":3,"target":1, 'type': 'mother'}
			{"source":5,"target":2, 'type': 'father'}
			{"source":6,"target":2, 'type': 'mother'}
			{"source":5,"target":7, 'type': 'father'}
			{"source":6,"target":7, 'type': 'mother'}
			{"source":0,"target":2, 'type': 'husband'}
			{"source":8,"target":3, 'type': 'father'}
			{"source":1,"target":9, 'type': 'husband'}
			{"source":1,"target":10, 'type': 'father'}
			{"source":9,"target":10, 'type': 'mother'}]
	nodes: [{'name':'Michael', 'last': 'Malura'}
			{'name':'Kai', 'last': 'Malura'}
			{'name':'Simone', 'last': 'Hirschle'}
			{'name':'Claudia', 'last': 'Golembusch'}
			{'name':'Berthold', 'last': 'Malura'}
			{'name':'Hans', 'last': 'Hirschle'}
			{'name':'Helga', 'last': 'Bohner'}
			{'name':'Bernhard', 'last': 'Hirschle'}
			{'name':'Alois', 'last': 'Golembusch'}
			{'name':'Denise', 'last': 'Mildenberger'}
			{'name':'Eva', 'last': 'Malura'}
			]

distinctLastNames = _.chain(data.nodes).pluck("last").unique().compact().value()
color = d3.scale.category10().domain(distinctLastNames)
svg = d3.select('svg')
	.attr('width', '100%')
	.attr('height', height)

resizeTimeout = null

initialize = ()->
	# svg.on 'mousedown', ()->
	# 	point = d3.mouse(this)
	# 	node = {
	# 		x: point[0],
	# 		y: point[1],
	# 		name: 'foo',
	# 		last: 'Malura'
	# 	}
	# 	n = data.nodes.push(node)
	# 	restart()

	window.onresize = ()->

	force = d3.layout.force()
		.charge(-200)
		.linkDistance(50)
		.friction(0.9)
		.size([width, height])
	for i in data.nodes
		i.x = width/2 + (Math.random()*100)-50 #the initial x position of node
		i.y = height/2 + (Math.random()*100)-50 #the initial y position of node
		
	force.nodes(data.nodes).links(data.links).start()
	force.on 'tick', ()->
		link.attr("x1", (d)->d.source.x)
			.attr("y1", (d)->d.source.y)
			.attr("x2", (d)->d.target.x)
			.attr("y2", (d)->d.target.y)
		node.attr("cx", (d)->d.x)
			.attr("cy", (d)->d.y)
		text.attr("x", (d)->d.x)
		    .attr("y", (d)->d.y)
	
	graph = svg.append('g')
		.attr('class', 'graph')
	link = graph.selectAll('.link')
		.data(data.links)
		.enter().append('line')
		.attr('class', 'link')
		.style('stroke-width', (d)->3);
	node = graph.selectAll('.node')
		.data(data.nodes)
		.enter().append('circle')
		.attr('class', 'node')
		.attr('r', 10)
		.style('fill', (d)->return color(d.last))
		.call(force.drag)
	text = graph.selectAll('.text')
	    .data(data.nodes)
	    .enter().append('text')
	    .attr('class', 'text')
	    .attr('dy', -15)
	    .text((d)->return d.name)
	    .call(force.drag)
		
	legend = svg.append('g')
		.attr('class', 'legend')
		.attr('transform', 'translate(25,25)')
	legend.selectAll('text')
		.data(distinctLastNames).enter()
		.append('text')
		.text((d, i)->d)
		.attr('x', 20)
		.attr('y', (d,i)->i*30+4)
	legend.selectAll('.legendNode')
		.data(distinctLastNames)
		.enter().append('circle')
		.attr('class', 'legendNode')
		.attr('r', 10)
		.style('fill', (d)->return color(d))
		.attr('cx', 0)
		.attr('cy', (d,i)->i*30)

	restart = ()->
		node = node.data(data.nodes)
		node.enter().insert('circle')
			.attr('class', 'node')
			.attr('r', 10)
			.style('fill', (d)->return color(d.last))
			.call(force.drag)
		force.start()

$(document).ready ()->
	initialize()