app = angular.module 'app', ['controller', 'directives']

directives = angular.module 'directives', []
controller = angular.module 'controller', []


controller.controller 'graph', ['$scope', (scope)->
	scope.data =
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
]


directives.directive 'graph', ()->
	restrict = 'E'
	replace = true
	template = '<svg></svg>'
	scope = {
		ngModel: '='
	}
	link = (scope, element, attrs)->
		svg = d3.select(element[0])
		console.log scope
		

	return {
		link
		restrict
		replace
		template
		scope
	}